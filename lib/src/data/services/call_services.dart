import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:call_log/call_log.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';


import '../../app/app.dart';
import '../../domain/entities/call_request.dart';
import '../../domain/entities/demo_model.dart';
import 'supabase_services.dart';


class CallService {
  static final CallService _instance = CallService._internal();
  factory CallService() => _instance;
  CallService._internal();
  
  // Track processed recordings to prevent duplicates
  final Set<String> _processedRecordings = <String>{};

  /// Make a direct call without showing the dialer
  Future<bool> makeDirectCall(String phoneNumber) async {
    try {
      
      String cleanNumber = _cleanPhoneNumber(phoneNumber);
      
      if (cleanNumber.isEmpty) {
        return await makeCallWithDialer(phoneNumber);
      }

      // Check permissions first
      bool hasPermission = await _hasCallPermission();
      if (!hasPermission) {
        hasPermission = await _requestCallPermission();
      }
      
      if (!hasPermission) {
        return await makeCallWithDialer(phoneNumber);
      }

      // Try direct call with comprehensive error handling
      try {
        await Future.delayed(Duration(milliseconds: 100)); // Small delay to ensure permissions are ready
        bool? result = await FlutterPhoneDirectCaller.callNumber(cleanNumber);
        if (result == true) {
          return true;
        } else {
          
          return await makeCallWithDialer(phoneNumber);
        }
      } on Exception catch (e) {
        
        return await makeCallWithDialer(phoneNumber);
      } catch (e) {
        
        return await makeCallWithDialer(phoneNumber);
      }
    } catch (e) {
      
      return await makeCallWithDialer(phoneNumber);
    }
  }

  /// Make a call using the system dialer (fallback option)
  Future<bool> makeCallWithDialer(String phoneNumber) async {
    try {
      String cleanNumber = _cleanPhoneNumber(phoneNumber);
      final Uri phoneUri = Uri(scheme: 'tel', path: cleanNumber);
      
      if (await canLaunchUrl(phoneUri)) {
        return await launchUrl(phoneUri);
      } else {
        throw Exception('Cannot launch phone dialer');
      }
    } catch (e) {
      print('Error making call with dialer: $e');
      return false;
    }
  }

  /// Check if the app has call permission
  Future<bool> _hasCallPermission() async {
    try {
      return await Permission.phone.isGranted;
    } catch (e) {
      
      return false;
    }
  }

  /// Request call permission
  Future<bool> _requestCallPermission() async {
    try {
      PermissionStatus status = await Permission.phone.request();
      return status == PermissionStatus.granted;
    } catch (e) {
      
      return false;
    }
  }

  /// Clean phone number by removing spaces, dashes, and other characters
  String _cleanPhoneNumber(String phoneNumber) {
    // Remove all non-numeric characters except + at the beginning
    String cleaned = phoneNumber.replaceAll(RegExp(r'[^\d+]'), '');
    
    // Ensure + is only at the beginning
    if (cleaned.startsWith('+')) {
      cleaned = '+' + cleaned.substring(1).replaceAll('+', '');
    }
    
    return cleaned;
  }

  /// Validate phone number format
  bool isValidPhoneNumber(String phoneNumber) {
    String cleaned = _cleanPhoneNumber(phoneNumber);
    // Basic validation: should have at least 10 digits
    return RegExp(r'^\+?\d{10,15}$').hasMatch(cleaned);
  }

  /// Start recording (placeholder - implement with actual recording plugin)
  Future<String?> startRecording() async {
    try {
      
      // Return mock path for now - implement with actual recording plugin
      return 'mock_recording_path_${DateTime.now().millisecondsSinceEpoch}.mp3';
    } catch (e) {
      
      return null;
    }
  }

  /// Stop recording (placeholder - implement with actual recording plugin)
  Future<String?> stopRecording() async {
    try {
      
      // Return mock path for now - implement with actual recording plugin
      return 'mock_recording_path_${DateTime.now().millisecondsSinceEpoch}.mp3';
    } catch (e) {
      
      return null;
    }
  }

  /// End call (placeholder)
  Future<void> endCall() async {
    try {
      
      // Implement call ending logic if needed
    } catch (e) {
      
    }
  }

  /// Sync all call recordings to Supabase storage
  Future<Map<String, dynamic>> syncCallRecordings() async {
    try {
      // Clear processed recordings at the start of sync to allow fresh processing
      _processedRecordings.clear();
      
      final supabaseService = getIt<SupabaseService>();
      final currentUser = await supabaseService.getCurrentUser();
      
      if (currentUser == null) {
        throw Exception('User not authenticated');
      }

      // Get all leads for phone number lookup
      final leads = await supabaseService.getLeads();
      final phoneToLeadMap = <String, Demo>{};
      
      for (final lead in leads) {
        if (lead.contactNo != null) {
          phoneToLeadMap[_cleanPhoneNumber(lead.contactNo!)] = lead;
        }
      }

      // Get call logs from device
      final callLogs = await _getDeviceCallLogs();
      
      int uploaded = 0;
      int failed = 0;
      
      for (final callLog in callLogs) {
        try {
          final phoneNumber = callLog['number'] ?? '';
          final contactName = callLog['name'] ?? callLog['cached_name'] ?? '';
          
          
          // Try to find lead by phone number or contact name
          Demo? lead;
          String cleanPhone = '';
          
          // First try to match by phone number
          if (phoneNumber != 'Unknown' && phoneNumber.isNotEmpty) {
            cleanPhone = _cleanPhoneNumber(phoneNumber);
            lead = phoneToLeadMap[cleanPhone];
            
          }
          
          // If no lead found by phone, try matching by contact name
          if (lead == null && contactName.isNotEmpty) {
            for (final leadEntry in phoneToLeadMap.entries) {
              final leadData = leadEntry.value;
              if (leadData.studentName?.toLowerCase().contains(contactName.toLowerCase()) == true ||
                  contactName.toLowerCase().contains(leadData.studentName?.toLowerCase() ?? '')) {
                lead = leadData;
                cleanPhone = leadEntry.key;
                
                break;
              }
            }
          }
          
          if (lead == null) {
            
            failed++;
            continue;
          }
          
          final studentName = (lead.studentName ?? 'Unknown').replaceAll(RegExp(r'[^\w\s]'), '');
          final timestamp = DateTime.fromMillisecondsSinceEpoch(callLog['timestamp'] ?? 0);
          
          // Create filename: StudentName_PhoneNumber_Timestamp (extension will be determined from actual file)
          final fileName = '${studentName.replaceAll(' ', '_')}_${cleanPhone}_${timestamp.millisecondsSinceEpoch}';
          final folderPath = '${currentUser.id}/$fileName';
          
          
          
          // Update callLog with actual phone number from lead if found
          if (lead != null && lead.contactNo != null) {
            callLog['number'] = lead.contactNo!;
            cleanPhone = _cleanPhoneNumber(lead.contactNo!);
          } else {
            callLog['number'] = cleanPhone.isNotEmpty ? cleanPhone : phoneNumber;
          }
          
          // Upload recording to Supabase storage
          await _uploadCallRecording(callLog, folderPath, lead, currentUser.id!);
          uploaded++;
        } catch (e) {
          
          failed++;
        }
      }
      
      return {
        'uploaded': uploaded,
        'failed': failed,
        'total': callLogs.length,
      };
    } catch (e) {
      
      throw Exception('Failed to sync recordings: $e');
    }
  }

  /// Get call logs from device using call_log package
  Future<List<Map<String, dynamic>>> _getDeviceCallLogs() async {
    try {
      // Check phone permission
      if (!await Permission.phone.isGranted) {
        final status = await Permission.phone.request();
        if (!status.isGranted) {
          
          return [];
        }
      }
      

      // Get call logs from device
      final Iterable<CallLogEntry> entries = await CallLog.get();
      

      return entries.map((entry) => {
        'number': entry.number ?? 'Unknown',
        'timestamp': entry.timestamp ?? DateTime.now().millisecondsSinceEpoch,
        'duration': entry.duration ?? 0,
        'type': entry.callType == CallType.outgoing ? 'outgoing' : 'incoming',
        'name': entry.name ?? '',
      }).toList();
    } catch (e) {
      
      return [];
    }
  }
  
  /// Scan recording directories for call recording files
  Future<List<File>> _scanRecordingDirectories() async {
    final List<File> recordingFiles = [];
    
    // Check storage permissions first
    if (!await Permission.storage.isGranted) {
      await Permission.storage.request();
    }
    if (!await Permission.manageExternalStorage.isGranted) {
      await Permission.manageExternalStorage.request();
    }
    
    final recordingPaths = [
      '/storage/emulated/0/Call recordings',
      '/storage/emulated/0/Recordings/Call recordings',
      '/storage/emulated/0/Recordings/Call',
      '/storage/emulated/0/MIUI/sound_recorder/call_rec',
      '/storage/emulated/0/PhoneRecord',
      '/storage/emulated/0/CallRecordings',
    ];
    
    for (final path in recordingPaths) {
      try {
  
        final dir = Directory(path);
     
        if (await dir.exists()) {
          final files = await dir.list(recursive: true, followLinks: false).toList();
          
          
          for (final file in files) {
            if (file is File) {
              final fileName = file.path.split('/').last.toLowerCase();
              final validExtensions = ['mp3', 'm4a', 'wav', 'aac', 'amr', '3gp'];
              
              if (validExtensions.any((ext) => fileName.endsWith('.$ext'))) {
                
                recordingFiles.add(file);
              }
            }
          }
        }
      } catch (e) {
        
        continue;
      }
    }
    
    return recordingFiles;
  }
  
  /// Extract phone number from filename
  String? _extractPhoneFromFileName(String filePath) {
    final fileName = filePath.split('/').last;
    
    
    // Try different phone number patterns
    final patterns = [
      RegExp(r'(\+?\d{10,15})'), // Standard phone format
      RegExp(r'_(\d{6,15})_'), // Numbers between underscores
      RegExp(r'\s(\d{10,15})\s'), // Numbers between spaces
      RegExp(r'(\d{10,15})'), // Any sequence of 10+ digits
    ];
    
    for (final pattern in patterns) {
      final match = pattern.firstMatch(fileName);
      if (match != null) {
        final phone = match.group(1)!;
        
        return phone;
      }
    }
    
    // If no phone found, use the contact name from filename
    final nameMatch = RegExp(r'Call recording (.+?)_').firstMatch(fileName);
    if (nameMatch != null) {
      final contactName = nameMatch.group(1)!;
      
      return contactName; // Return name to match against leads
    }
    
    
    return null;
  }

  /// Upload individual call recording
  Future<void> _uploadCallRecording(
    Map<String, dynamic> callLog,
    String storagePath,
    Demo? lead,
    String userId,
  ) async {
    try {
      final supabaseService = getIt<SupabaseService>();
      
      // Find and read actual recording file from device
      final recordingFile = await _findCallRecordingFile(callLog);
      if (recordingFile == null) {
        
        return;
      }
      
      // Verify file exists and is readable
      if (!await recordingFile.exists()) {
        
        return;
      }
      
      final fileSize = await recordingFile.length();
      if (fileSize == 0) {
        
        return;
      }
      
      
      final audioData = await recordingFile.readAsBytes();
      final fileExtension = recordingFile.path.split('.').last.toLowerCase();
      
      // Validate file extension
      final validExtensions = ['mp3', 'm4a', 'wav', 'aac', 'amr', '3gp'];
      if (!validExtensions.contains(fileExtension)) {
        
        return;
      }
      
      // Update storage path with correct extension
      final correctedStoragePath = '$storagePath.$fileExtension';
      
      
      
      // Upload file to Supabase storage
      await supabaseService.client.storage
          .from('call-recordings')
          .uploadBinary(correctedStoragePath, audioData);
      
      // Get public URL
      final publicUrl = supabaseService.client.storage
          .from('call-recordings')
          .getPublicUrl(correctedStoragePath);
      
      // Create call recording metadata
      final recordingData = {
        'phone_number': callLog['number'],
        'duration_seconds': callLog['duration'] ?? 0,
        'start_time': DateTime.fromMillisecondsSinceEpoch(callLog['timestamp'] ?? 0).toIso8601String(),
        'end_time': DateTime.fromMillisecondsSinceEpoch((callLog['timestamp'] ?? 0) + ((callLog['duration'] ?? 0) * 1000)).toIso8601String(),
        'call_status': 'completed',
        'caller_id': userId,
        'recording_file_path': correctedStoragePath,
        'recording_file_url': publicUrl,
        'file_size_bytes': audioData.length,
        'audio_format': fileExtension,
        'call_type': callLog['type'] ?? 'outbound',
        'call_direction': callLog['type'] ?? 'outbound',
        'metadata': {
          'lead_name': lead?.studentName ?? 'Unknown',
          'synced_at': DateTime.now().toIso8601String(),
          'original_file_path': recordingFile.path,
        },
      };
      
      // Save to database
      await supabaseService.createCallRecording(recordingData);
      
      
    } catch (e) {
      
      rethrow;
    }
  }
  
  /// Find call recording file in device storage
  Future<File?> _findCallRecordingFile(Map<String, dynamic> callLog) async {
    try {
      final phoneNumber = _cleanPhoneNumber(callLog['number'] ?? '');
      final contactName = callLog['name'] ??  '';
      final timestamp = callLog['timestamp'] ?? 0;

      
      
      if (phoneNumber.isEmpty) {
        
        return null;
      }
      
      // Common call recording directories on Android
      final recordingPaths = [
        '/storage/emulated/0/Call recordings',
        '/storage/emulated/0/Recordings/Call recordings',
        '/storage/emulated/0/MIUI/sound_recorder/call_rec',
        '/storage/emulated/0/PhoneRecord',
        '/storage/emulated/0/CallRecordings',
        '/storage/emulated/0/Recordings/Call',
      ];
      
      for (final path in recordingPaths) {
        try {
          
          final dir = Directory(path);
          if (await dir.exists()) {
            final files = await dir.list(recursive: false, followLinks: false).toList();
            
            for (final file in files) {
              if (file is File) {
                try {
                  final fileName = file.path.split('/').last.toLowerCase();
                  final cleanFileName = fileName.replaceAll(RegExp(r'[^\w\d.]'), '');
                  
                  
                  
                  // Check if file matches phone number and approximate timestamp
                  if (fileName.contains(phoneNumber.toLowerCase()) || 
                      cleanFileName.contains(phoneNumber) || fileName.contains(contactName.toString().toLowerCase()) || 
                      _isRecordingFileMatch(fileName, phoneNumber, timestamp)) {
                    
                    // Check if this recording has already been processed
                    if (_processedRecordings.contains(file.path)) {
                      continue;
                    }
                    
                    // Verify file is readable and not empty
                    final fileSize = await file.length();
                    if (fileSize > 0) {
                      // Mark as processed to prevent duplicate processing
                      _processedRecordings.add(file.path);
                      return file;
                    }
                  }
                } catch (fileError) {
                  
                  continue;
                }
              }
            }
          }
        } catch (dirError) {
          
          continue;
        }
      }
      
      
      return null;
    } catch (e) {
      
      return null;
    }
  }
  
  /// Check if recording file matches the call
  bool _isRecordingFileMatch(String fileName, String phoneNumber, int timestamp) {
    final lowerFileName = fileName.toLowerCase();
    final cleanPhone = phoneNumber.replaceAll(RegExp(r'[^\d]'), '');
    
    // Check if filename contains phone number (try different formats)
    if (lowerFileName.contains(phoneNumber.toLowerCase()) ||
        lowerFileName.contains(cleanPhone) ||
        (cleanPhone.length >= 10 && lowerFileName.contains(cleanPhone.substring(cleanPhone.length - 10)))) {
      return true;
    }
    
    // Check timestamp proximity (within 5 minutes)
    final fileTimestamp = _extractTimestampFromFileName(fileName);
    if (fileTimestamp != null) {
      final timeDiff = (timestamp - fileTimestamp).abs();
      return timeDiff < 300000; // 5 minutes in milliseconds
    }
    
    return false;
  }
  
  /// Extract timestamp from filename if present
  int? _extractTimestampFromFileName(String fileName) {
    final timestampRegex = RegExp(r'(\d{10,13})');
    final match = timestampRegex.firstMatch(fileName);
    if (match != null) {
      return int.tryParse(match.group(1)!);
    }
    return null;
  }
}

// Call state management
enum CallState {
  idle,
  dialing,
  ringing,
  connected,
  ended,
  failed
}

class CallManager {
  static final CallManager _instance = CallManager._internal();
  factory CallManager() => _instance;
  CallManager._internal();

  CallState _currentState = CallState.idle;
  String? _currentCallId;
  DateTime? _callStartTime;

  CallState get currentState => _currentState;
  String? get currentCallId => _currentCallId;
  DateTime? get callStartTime => _callStartTime;

  Future<bool> initiateCall(CallRequest callRequest) async {
    try {
      _currentState = CallState.dialing;
      _currentCallId = callRequest.id;
      _callStartTime = DateTime.now();

      // Make the actual call
      bool success = await getIt<CallService>().makeDirectCall(callRequest.phoneNumber);
      
      if (success) {
        _currentState = CallState.ringing;
        return true;
      } else {
        _currentState = CallState.failed;
        return false;
      }
    } catch (e) {
      _currentState = CallState.failed;
      print('Error initiating call: $e');
      return false;
    }
  }

  void markCallAsConnected() {
    if (_currentState == CallState.ringing) {
      _currentState = CallState.connected;
    }
  }

  void endCall() {
    _currentState = CallState.ended;
    _currentCallId = null;
    _callStartTime = null;
  }

  Duration? getCallDuration() {
    if (_callStartTime != null && _currentState == CallState.connected) {
      return DateTime.now().difference(_callStartTime!);
    }
    return null;
  }
}