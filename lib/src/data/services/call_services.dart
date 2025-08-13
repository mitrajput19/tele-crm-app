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



  /// Sync call recordings (optimized for speed)
  Future<Map<String, dynamic>> syncCallRecordings() async {
    try {
      _processedRecordings.clear();
      
      final supabaseService = getIt<SupabaseService>();
      final currentUser = await supabaseService.getCurrentUser();
      
      if (currentUser == null) throw Exception('User not authenticated');

      // Get recent call logs only (last 24 hours)
      final yesterday = DateTime.now().subtract(Duration(hours: 24));
      final allCallLogs = await _getDeviceCallLogs();
      final recentCallLogs = allCallLogs.where((log) {
        final timestamp = log['timestamp'] ?? 0;
        return DateTime.fromMillisecondsSinceEpoch(timestamp).isAfter(yesterday);
      }).take(20).toList(); // Limit to 20 most recent
      
      if (recentCallLogs.isEmpty) {
        return {'uploaded': 0, 'failed': 0, 'total': 0};
      }

      // Get leads and create phone map
      final leads = await supabaseService.getLeads();
      final phoneToLeadMap = <String, Demo>{};
      for (final lead in leads) {
        if (lead.contactNo != null) {
          phoneToLeadMap[_cleanPhoneNumber(lead.contactNo!)] = lead;
        }
      }
      
      int uploaded = 0;
      int failed = 0;
      
      // Process in batches of 3 to avoid overwhelming
      const batchSize = 3;
      for (int i = 0; i < recentCallLogs.length; i += batchSize) {
        final batch = recentCallLogs.skip(i).take(batchSize);
        
        await Future.wait(batch.map((callLog) async {
          try {
            final phoneNumber = callLog['number'] ?? '';
            final contactName = callLog['name'] ?? '';
            
            Demo? lead;
            String cleanPhone = '';
            
            if (phoneNumber != 'Unknown' && phoneNumber.isNotEmpty) {
              cleanPhone = _cleanPhoneNumber(phoneNumber);
              lead = phoneToLeadMap[cleanPhone];
            }
            
            if (lead == null && contactName.isNotEmpty) {
              for (final entry in phoneToLeadMap.entries) {
                if (entry.value.studentName?.toLowerCase().contains(contactName.toLowerCase()) == true) {
                  lead = entry.value;
                  cleanPhone = entry.key;
                  break;
                }
              }
            }
            
            if (lead == null) {
              failed++;
              return;
            }
            
            final studentName = (lead.studentName ?? 'Unknown').replaceAll(RegExp(r'[^\w\s]'), '');
            final timestamp = DateTime.fromMillisecondsSinceEpoch(callLog['timestamp'] ?? 0);
            final fileName = '${studentName.replaceAll(' ', '_')}_${cleanPhone}_${timestamp.millisecondsSinceEpoch}';
            final folderPath = '${currentUser.id}/$fileName';
            
            callLog['number'] = lead.contactNo ?? cleanPhone;
            
            await _uploadCallRecording(callLog, folderPath, lead, currentUser.id!);
            uploaded++;
          } catch (e) {
            failed++;
          }
        }));
      }
      
      return {
        'uploaded': uploaded,
        'failed': failed,
        'total': recentCallLogs.length,
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
      
      // Get user-defined recording path or use common paths as fallback
      final userSettings = await getIt<SupabaseService>().getUserSettings();
      final recordingPaths = <String>[];
      
      // Add user-defined path first if available
      if (userSettings?.callRecordingPath != null && userSettings!.callRecordingPath!.isNotEmpty) {
        recordingPaths.add(userSettings.callRecordingPath!);
      }
      
      // Add common paths as fallback
      recordingPaths.addAll([
        '/storage/emulated/0/Call recordings',
        '/storage/emulated/0/Recordings/Call recordings',
        '/storage/emulated/0/MIUI/sound_recorder/call_rec',
        '/storage/emulated/0/PhoneRecord',
        '/storage/emulated/0/CallRecordings',
        '/storage/emulated/0/Recordings/Call',
      ]);
      
      for (final path in recordingPaths) {
        try {
          final dir = Directory(path);
          if (await dir.exists()) {
            // Get only recent files (last 24 hours) to speed up search
            final yesterday = DateTime.now().subtract(Duration(hours: 24));
            final files = await dir.list(recursive: false, followLinks: false)
                .where((file) {
                  if (file is File) {
                    try {
                      final stat = file.statSync();
                      return stat.modified.isAfter(yesterday);
                    } catch (e) {
                      return true; // Include if we can't check date
                    }
                  }
                  return false;
                })
                .take(50) // Limit to 50 files max
                .toList();
            
            for (final file in files) {
              if (file is File) {
                try {
                  final fileName = file.path.split('/').last.toLowerCase();
                  
                  if (_processedRecordings.contains(file.path)) continue;
                  
                  if (fileName.contains(phoneNumber.toLowerCase()) || 
                      fileName.contains(contactName.toString().toLowerCase()) || 
                      _isRecordingFileMatch(fileName, phoneNumber, timestamp)) {
                    
                    final fileSize = await file.length();
                    if (fileSize > 0) {
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

