
import 'dart:io';
import 'dart:developer';
import 'package:path/path.dart' as path;
import 'package:permission_handler/permission_handler.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../app/app.dart';

class CallRecordingService {
  static final CallRecordingService _instance = CallRecordingService._internal();
  factory CallRecordingService() => _instance;
  CallRecordingService._internal();

  static const List<String> _possibleRecordingPaths = [
    '/storage/emulated/0/Recordings/Call',
    '/storage/emulated/0/MIUI/sound_recorder/call_rec',
    '/storage/emulated/0/CallRecordings',
    '/storage/emulated/0/PhoneRecord',
    '/storage/emulated/0/Android/data/com.android.dialer/files/CallRecords',
    '/storage/emulated/0/Call',
    '/storage/emulated/0/Recordings',
    '/sdcard/CallRecorder',
    '/sdcard/Recordings/Call',
  ];

  String? _recordingDirectory;
  DateTime? _lastSyncTime;

  /// Initialize recording service and find recording directory
  Future<bool> initialize() async {
    try {
      // Check permissions
      if (!await _checkPermissions()) {
        log('CallRecordingService: Required permissions not granted');
        return false;
      }

      // Find recording directory
      _recordingDirectory = await _findRecordingDirectory();
      if (_recordingDirectory == null) {
        log('CallRecordingService: No recording directory found');
        return false;
      }

      log('CallRecordingService: Initialized with directory: $_recordingDirectory');
      return true;
    } catch (e) {
      log('CallRecordingService: Error initializing: $e');
      return false;
    }
  }

  /// Check required permissions
  Future<bool> _checkPermissions() async {
    final permissions = [
      Permission.storage,
      Permission.manageExternalStorage,
      Permission.accessMediaLocation,
    ];

    for (final permission in permissions) {
      if (!await permission.isGranted) {
        final status = await permission.request();
        if (!status.isGranted) {
          return false;
        }
      }
    }
    return true;
  }

  /// Find the actual recording directory on the device
  Future<String?> _findRecordingDirectory() async {
    for (final path in _possibleRecordingPaths) {
      try {
        final directory = Directory(path);
        if (await directory.exists()) {
          final files = await directory.list().toList();
          // Check if directory contains audio files
          final hasAudioFiles = files.any((file) => 
            file is File && _isAudioFile(file.path));
          if (hasAudioFiles) {
            return path;
          }
        }
      } catch (e) {
        continue;
      }
    }
    return null;
  }

  /// Check if file is an audio file
  bool _isAudioFile(String filePath) {
    final extension = path.extension(filePath).toLowerCase();
    return ['.mp3', '.wav', '.m4a', '.aac', '.amr', '.3gp'].contains(extension);
  }

  /// Monitor for new recordings and sync automatically
  Future<List<String>> monitorNewRecordings() async {
    if (_recordingDirectory == null) {
      if (!await initialize()) {
        return [];
      }
    }

    try {
      final directory = Directory(_recordingDirectory!);
      final files = await directory
          .list()
          .where((file) => file is File && _isAudioFile(file.path))
          .cast<File>()
          .toList();

      final newFiles = <String>[];
      final currentTime = DateTime.now();

      for (final file in files) {
        final stat = await file.stat();
        
        // Check if file was created after last sync
        if (_lastSyncTime == null || stat.modified.isAfter(_lastSyncTime!)) {
          // Additional check: file should be recent (within last hour)
          if (currentTime.difference(stat.modified).inHours < 1) {
            newFiles.add(file.path);
          }
        }
      }

      _lastSyncTime = currentTime;
      return newFiles;
    } catch (e) {
      log('CallRecordingService: Error monitoring recordings: $e');
      return [];
    }
  }

  /// Get all recording files for manual sync
  Future<List<String>> getAllRecordings() async {
    if (_recordingDirectory == null) {
      if (!await initialize()) {
        return [];
      }
    }

    try {
      final directory = Directory(_recordingDirectory!);
      final files = await directory
          .list()
          .where((file) => file is File && _isAudioFile(file.path))
          .cast<File>()
          .map((file) => file.path)
          .toList();

      return files;
    } catch (e) {
      log('CallRecordingService: Error getting recordings: $e');
      return [];
    }
  }

  /// Sync recording to Supabase
  Future<bool> syncRecording(String filePath) async {
    try {
      final file = File(filePath);
      if (!await file.exists()) {
        log('CallRecordingService: File does not exist: $filePath');
        return false;
      }

      final fileName = path.basename(filePath);
      final fileStats = await file.stat();
      
      // Extract phone number and timestamp from filename if possible
      final phoneNumber = _extractPhoneNumberFromFilename(fileName);
      final recordingTime = _extractTimeFromFilename(fileName) ?? fileStats.modified;

      // Find matching demo/lead
      final clientInfo = await _findClientInfo(phoneNumber, recordingTime);
      
      if (clientInfo == null) {
        log('CallRecordingService: No matching client found for $phoneNumber');
        return false;
      }

      // Get current user
      final currentUser = Supabase.instance.client.auth.currentUser;
      if (currentUser == null) {
        log('CallRecordingService: No authenticated user');
        return false;
      }

      // Create folder structure: user-UUID/client-name/timestamp.extension
      final userUuid = currentUser.id;
      final clientName = _sanitizeFilename(clientInfo['name'] as String);
      final timestamp = recordingTime.millisecondsSinceEpoch;
      final extension = path.extension(filePath);
      
      final storagePath = '$userUuid/$clientName/${timestamp}$extension';

      // Upload to Supabase Storage
      final bytes = await file.readAsBytes();
      await Supabase.instance.client.storage
          .from('call-recordings')
          .uploadBinary(storagePath, bytes);

      // Get public URL
      final publicUrl = Supabase.instance.client.storage
          .from('call-recordings')
          .getPublicUrl(storagePath);

      // Save call recording record to database
      await getIt<SupabaseService>().createCallRecording({
        'contact_id': clientInfo['contact_id'],
        'demo_request_id': clientInfo['demo_id'],
        'caller_id': userUuid,
        'phone_number': phoneNumber ?? clientInfo['phone'],
        'call_type': 'outbound',
        'call_status': 'completed',
        'start_time': recordingTime.toIso8601String(),
        'recording_file_url': publicUrl,
        'recording_file_path': storagePath,
        'file_size_bytes': bytes.length,
        'audio_format': extension.replaceFirst('.', ''),
        'metadata': {
          'original_filename': fileName,
          'sync_timestamp': DateTime.now().toIso8601String(),
          'auto_synced': true,
        },
      });

      log('CallRecordingService: Successfully synced $filePath');
      return true;
    } catch (e) {
      log('CallRecordingService: Error syncing recording: $e');
      return false;
    }
  }

  /// Extract phone number from filename
  String? _extractPhoneNumberFromFilename(String filename) {
    // Common patterns for phone numbers in filenames
    final patterns = [
      RegExp(r'(\+?\d{10,15})'),
      RegExp(r'(\d{10,15})'),
    ];

    for (final pattern in patterns) {
      final match = pattern.firstMatch(filename);
      if (match != null) {
        return match.group(1);
      }
    }
    return null;
  }

  /// Extract timestamp from filename
  DateTime? _extractTimeFromFilename(String filename) {
    try {
      // Common timestamp patterns
      final patterns = [
        RegExp(r'(\d{4})(\d{2})(\d{2})_(\d{2})(\d{2})(\d{2})'),
        RegExp(r'(\d{4})-(\d{2})-(\d{2})_(\d{2})-(\d{2})-(\d{2})'),
        RegExp(r'(\d{13})'), // Unix timestamp in milliseconds
      ];

      for (final pattern in patterns) {
        final match = pattern.firstMatch(filename);
        if (match != null) {
          if (match.groupCount == 1) {
            // Unix timestamp
            final timestamp = int.tryParse(match.group(1)!);
            if (timestamp != null) {
              return DateTime.fromMillisecondsSinceEpoch(timestamp);
            }
          } else if (match.groupCount == 6) {
            // Date format
            return DateTime(
              int.parse(match.group(1)!),
              int.parse(match.group(2)!),
              int.parse(match.group(3)!),
              int.parse(match.group(4)!),
              int.parse(match.group(5)!),
              int.parse(match.group(6)!),
            );
          }
        }
      }
    } catch (e) {
      log('CallRecordingService: Error extracting time from filename: $e');
    }
    return null;
  }

  /// Find client info from demo/lead data
  Future<Map<String, dynamic>?> _findClientInfo(String? phoneNumber, DateTime recordingTime) async {
    try {
      final supabaseService = getIt<SupabaseService>();
      
      if (phoneNumber != null) {
        // First try to find in demos
        final demos = await supabaseService.getLeads(limit: 100);
        for (final demo in demos) {
          if (demo.contactNo == phoneNumber || 
              demo.alternateContactNo == phoneNumber) {
            return {
              'name': demo.studentName,
              'phone': demo.contactNo,
              'contact_id': null,
              'demo_id': demo.id,
            };
          }
        }

        // Then try leads (if you have a separate leads table)
        // This would require implementing getLeads method for actual leads
      }

      // If no exact match, try to find recent demos around the recording time
      final demos = await supabaseService.getLeads(limit: 50);
      final sortedDemos = demos
          .where((demo) => 
              demo.demoDate != null &&
              recordingTime.difference(demo.demoDate!).abs().inHours < 2)
          .toList()
        ..sort((a, b) => 
            recordingTime.difference(a.demoDate!).abs().compareTo(
                recordingTime.difference(b.demoDate!).abs()));

      if (sortedDemos.isNotEmpty) {
        final demo = sortedDemos.first;
        return {
          'name': demo.studentName,
          'phone': demo.contactNo,
          'contact_id': null,
          'demo_id': demo.id,
        };
      }

      return null;
    } catch (e) {
      log('CallRecordingService: Error finding client info: $e');
      return null;
    }
  }

  /// Sanitize filename for storage
  String _sanitizeFilename(String filename) {
    return filename
        .replaceAll(RegExp(r'[^\w\s-]'), '')
        .replaceAll(RegExp(r'\s+'), '_')
        .toLowerCase();
  }

  /// Sync multiple recordings
  Future<Map<String, bool>> syncMultipleRecordings(List<String> filePaths) async {
    final results = <String, bool>{};
    
    for (final filePath in filePaths) {
      results[filePath] = await syncRecording(filePath);
      // Add small delay to avoid overwhelming the server
      await Future.delayed(const Duration(milliseconds: 500));
    }
    
    return results;
  }

  /// Get sync statistics
  Future<Map<String, int>> getSyncStats() async {
    try {
      final allRecordings = await getAllRecordings();
      final supabaseService = getIt<SupabaseService>();
      final callRecordings = await supabaseService.getCallLogs(limit: 1000);
      
      final syncedCount = callRecordings
          .where((log) => log.recordingUrl != null)
          .length;
          
      return {
        'total_local': allRecordings.length,
        'total_synced': syncedCount,
        'pending_sync': allRecordings.length - syncedCount,
      };
    } catch (e) {
      log('CallRecordingService: Error getting sync stats: $e');
      return {
        'total_local': 0,
        'total_synced': 0,
        'pending_sync': 0,
      };
    }
  }
}
