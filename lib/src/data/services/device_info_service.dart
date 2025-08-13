import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../app/app.dart';

class DeviceInfoService {
  static final DeviceInfoService _instance = DeviceInfoService._internal();
  factory DeviceInfoService() => _instance;
  DeviceInfoService._internal();

  Future<Map<String, String>> getDeviceInfo() async {
    final deviceInfo = DeviceInfoPlugin();
    final packageInfo = await PackageInfo.fromPlatform();

    String deviceModel = 'Unknown';
    String deviceBrand = 'Unknown';
    String osVersion = 'Unknown';

    try {
      if (Platform.isAndroid) {
        final androidInfo = await deviceInfo.androidInfo;
        deviceModel = androidInfo.model;
        deviceBrand = androidInfo.brand;
        osVersion = 'Android ${androidInfo.version.release}';
      } else if (Platform.isIOS) {
        final iosInfo = await deviceInfo.iosInfo;
        deviceModel = iosInfo.model;
        deviceBrand = 'Apple';
        osVersion = 'iOS ${iosInfo.systemVersion}';
      }
    } catch (e) {
      // Handle error silently
    }

    return {
      'deviceModel': deviceModel,
      'deviceBrand': deviceBrand,
      'osVersion': osVersion,
      'appVersion': packageInfo.version,
    };
  }

  Future<void> updateUserDeviceInfo() async {
    try {
      final deviceInfo = await getDeviceInfo();
      final supabaseService = getIt<SupabaseService>();
      
      await supabaseService.updateUserSettings(
        deviceModel: deviceInfo['deviceModel'],
        deviceBrand: deviceInfo['deviceBrand'],
        osVersion: deviceInfo['osVersion'],
        appVersion: deviceInfo['appVersion'],
      );
    } catch (e) {
      // Handle error silently
    }
  }
}