import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'dart:io';

enum AppPermission {
  callLogs,
  contacts,
  phone,
  systemAlertWindow,
  manageExternalStorage,
}

class PermissionHandlerService {
  static final PermissionHandlerService _instance = PermissionHandlerService._internal();
  factory PermissionHandlerService() => _instance;
  PermissionHandlerService._internal();

  final DeviceInfoPlugin _deviceInfo = DeviceInfoPlugin();

  // Map permissions to their respective Permission objects
  static const Map<AppPermission, Permission> _permissionMap = {
    AppPermission.callLogs: Permission.phone,
    AppPermission.contacts: Permission.contacts,
    AppPermission.phone: Permission.phone,
    AppPermission.systemAlertWindow: Permission.systemAlertWindow,
    AppPermission.manageExternalStorage: Permission.manageExternalStorage,
  };

  // Get user-friendly permission names
  static const Map<AppPermission, String> _permissionNames = {
    AppPermission.callLogs: 'Call Logs',
    AppPermission.contacts: 'Contacts',
    AppPermission.phone: 'Phone',
    AppPermission.systemAlertWindow: 'Display over other apps',
    AppPermission.manageExternalStorage: 'Manage External Storage',
  };

  // Get permission descriptions for user
  static const Map<AppPermission, String> _permissionDescriptions = {
    AppPermission.callLogs: 'Access call logs to track communication history',
    AppPermission.contacts: 'Access contacts to manage customer information',
    AppPermission.phone: 'Make and manage phone calls',
    AppPermission.systemAlertWindow: 'Display app content over other applications',
    AppPermission.manageExternalStorage: 'Manage files and storage',
  };

  /// Check if a specific permission is granted
  Future<bool> isPermissionGranted(AppPermission permission) async {
    try {
      final Permission perm = _permissionMap[permission]!;
      final status = await perm.status;
      return status == PermissionStatus.granted;
    } catch (e) {
      debugPrint('Error checking permission ${permission.name}: $e');
      return false;
    }
  }

  /// Check multiple permissions at once
  Future<Map<AppPermission, bool>> checkPermissions(List<AppPermission> permissions) async {
    final Map<AppPermission, bool> results = {};
    
    for (final permission in permissions) {
      results[permission] = await isPermissionGranted(permission);
    }
    
    return results;
  }

  /// Request a single permission
  Future<PermissionStatus> requestPermission(AppPermission permission) async {
    try {
      final Permission perm = _permissionMap[permission]!;
      
      // Special handling for system alert window
      if (permission == AppPermission.systemAlertWindow) {
        return await _requestSystemAlertWindow();
      }
      
      // Special handling for manage external storage on Android 11+
      if (permission == AppPermission.manageExternalStorage) {
        return await _requestManageExternalStorage();
      }

      final status = await perm.request();
      return status;
    } catch (e) {
      debugPrint('Error requesting permission ${permission.name}: $e');
      return PermissionStatus.denied;
    }
  }

  /// Request multiple permissions
  Future<Map<AppPermission, PermissionStatus>> requestPermissions(List<AppPermission> permissions) async {
    final Map<AppPermission, PermissionStatus> results = {};
    
    for (final permission in permissions) {
      results[permission] = await requestPermission(permission);
    }
    
    return results;
  }

  /// Request all required permissions for the app
  Future<Map<AppPermission, PermissionStatus>> requestAllRequiredPermissions() async {
    final requiredPermissions = [
      AppPermission.callLogs,
      AppPermission.contacts,
      AppPermission.phone,
      AppPermission.systemAlertWindow,
    ];
    
    return await requestPermissions(requiredPermissions);
  }

  /// Check if all required permissions are granted
  Future<bool> areAllRequiredPermissionsGranted() async {
    final requiredPermissions = [
      AppPermission.callLogs,
      AppPermission.contacts,
      AppPermission.phone,
      AppPermission.systemAlertWindow,
    ];
    
    final results = await checkPermissions(requiredPermissions);
    return results.values.every((granted) => granted);
  }

  /// Handle system alert window permission (Display over other apps)
  Future<PermissionStatus> _requestSystemAlertWindow() async {
    try {
      if (Platform.isAndroid) {
        final androidInfo = await _deviceInfo.androidInfo;
        
        // For Android 6.0 (API 23) and above
        if (androidInfo.version.sdkInt >= 23) {
          final status = await Permission.systemAlertWindow.request();
          return status;
        }
      }
      
      return PermissionStatus.granted; // Not needed for older versions
    } catch (e) {
      debugPrint('Error requesting system alert window permission: $e');
      return PermissionStatus.denied;
    }
  }

  /// Handle manage external storage permission (Android 11+)
  Future<PermissionStatus> _requestManageExternalStorage() async {
    try {
      if (Platform.isAndroid) {
        final androidInfo = await _deviceInfo.androidInfo;
        
        // For Android 11 (API 30) and above
        if (androidInfo.version.sdkInt >= 30) {
          final status = await Permission.manageExternalStorage.request();
          return status;
        } else {
          // For older versions, use regular storage permission
          return await Permission.storage.request();
        }
      }
      
      return PermissionStatus.granted; // Not applicable for iOS
    } catch (e) {
      debugPrint('Error requesting manage external storage permission: $e');
      return PermissionStatus.denied;
    }
  }

  /// Open app settings if permission is permanently denied
  Future<bool> openAppSettings() async {
    try {
      return await openAppSettings();
    } catch (e) {
      debugPrint('Error opening app settings: $e');
      return false;
    }
  }

  /// Show permission dialog to user
  Future<bool> showPermissionDialog(
    BuildContext context,
    AppPermission permission, {
    String? customTitle,
    String? customMessage,
  }) async {
    final title = customTitle ?? 'Permission Required';
    final message = customMessage ?? 
        'This app needs ${_permissionNames[permission]} permission to function properly. '
        '${_permissionDescriptions[permission]}';

    return await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text('Grant Permission'),
            ),
          ],
        );
      },
    ) ?? false;
  }

  /// Show permission rationale dialog
  Future<bool> showPermissionRationale(
    BuildContext context,
    List<AppPermission> deniedPermissions,
  ) async {
    final permissionNames = deniedPermissions
        .map((p) => _permissionNames[p])
        .join(', ');

    return await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Permissions Required'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('This app requires the following permissions to work properly:'),
              const SizedBox(height: 12),
              ...deniedPermissions.map((permission) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('• '),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _permissionNames[permission]!,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            _permissionDescriptions[permission]!,
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text('Grant Permissions'),
            ),
          ],
        );
      },
    ) ?? false;
  }

  /// Handle permission workflow with user interaction
  Future<bool> handlePermissionFlow(
    BuildContext context,
    List<AppPermission> permissions, {
    String? title,
    String? message,
  }) async {
    try {
      // First check current status
      final currentStatus = await checkPermissions(permissions);
      final deniedPermissions = currentStatus.entries
          .where((entry) => !entry.value)
          .map((entry) => entry.key)
          .toList();

      if (deniedPermissions.isEmpty) {
        return true; // All permissions already granted
      }

      // Show rationale dialog
      final shouldRequest = await showPermissionRationale(context, deniedPermissions);
      if (!shouldRequest) {
        return false;
      }

      // Request permissions
      final results = await requestPermissions(deniedPermissions);
      
      // Check results
      final stillDenied = results.entries
          .where((entry) => entry.value != PermissionStatus.granted)
          .map((entry) => entry.key)
          .toList();

      if (stillDenied.isEmpty) {
        return true; // All permissions granted
      }

      // Handle permanently denied permissions
      final permanentlyDenied = <AppPermission>[];
      for (final permission in stillDenied) {
        final perm = _permissionMap[permission]!;
        if (await perm.isPermanentlyDenied) {
          permanentlyDenied.add(permission);
        }
      }

      if (permanentlyDenied.isNotEmpty) {
        // Show dialog to open settings
        final shouldOpenSettings = await _showOpenSettingsDialog(context, permanentlyDenied);
        if (shouldOpenSettings) {
          await openAppSettings();
        }
        return false;
      }

      return stillDenied.isEmpty;
    } catch (e) {
      debugPrint('Error in permission flow: $e');
      return false;
    }
  }

  /// Show dialog to open app settings for permanently denied permissions
  Future<bool> _showOpenSettingsDialog(
    BuildContext context,
    List<AppPermission> permanentlyDenied,
  ) async {
    final permissionNames = permanentlyDenied
        .map((p) => _permissionNames[p])
        .join(', ');

    return await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Permissions Required'),
          content: Text(
            'The following permissions were permanently denied: $permissionNames\n\n'
            'Please enable them manually in the app settings to continue.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text('Open Settings'),
            ),
          ],
        );
      },
    ) ?? false;
  }

  /// Get permission status summary
  Future<Map<String, dynamic>> getPermissionSummary() async {
    final allPermissions = AppPermission.values;
    final statusMap = <String, dynamic>{};
    
    for (final permission in allPermissions) {
      final isGranted = await isPermissionGranted(permission);
      statusMap[_permissionNames[permission]!] = {
        'granted': isGranted,
        'description': _permissionDescriptions[permission],
      };
    }
    
    return statusMap;
  }
}