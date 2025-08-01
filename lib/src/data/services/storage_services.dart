import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../app/app.dart';

class StorageServices {
  static Future initializeHive() async {
    await Hive.initFlutter();
  }

  static getBox(String key) async => await Hive.openBox(key);

  Future<SharedPreferences> getSharedPreferencesInstance() async {
    return await SharedPreferences.getInstance();
  }

  Future<FlutterSecureStorage> getSecureStorageInstance() async {
    return await FlutterSecureStorage();
  }

  Future setSecureTenantCode(String data) async {
    this.log(data, tag: 'setSecureTenantCode');
    final secureStorage = await getSecureStorageInstance();
    await secureStorage.write(key: SecureStorageKeys.tenantCode, value: data);
  }

  Future getSecureTenantCode() async {
    final secureStorage = await getSecureStorageInstance();
    String? data = await secureStorage.read(key: SecureStorageKeys.tenantCode);
    this.log(data, tag: 'getSecureTenantCode');
    return data ?? '';
  }

  Future setSecureTenantCodeEncrypted(String data) async {
    this.log(data, tag: 'setSecureTenantCodeEncrypted');
    final secureStorage = await getSecureStorageInstance();
    await secureStorage.write(key: SecureStorageKeys.tenantCodeEncrypted, value: data);
  }



  Future setDarkMode(bool data) async {
    this.log(data, tag: 'setDarkMode');
    final prefs = await getSharedPreferencesInstance();
    await prefs.setBool(StorageKeys.darkMode, data);
  }

  Future<bool> getDarkMode() async {
    final prefs = await getSharedPreferencesInstance();
    bool? data = await prefs.getBool(StorageKeys.darkMode);
    this.log(data, tag: 'getDarkMode');
    return data ?? false;
  }

  Future setTwoFactAuth(bool data) async {
    this.log(data, tag: 'setTwoFactAuth');
    final prefs = await getSharedPreferencesInstance();
    await prefs.setBool(StorageKeys.twoFactAuth, data);
  }

  Future<bool> getTwoFactAuth() async {
    final prefs = await getSharedPreferencesInstance();
    bool? data = await prefs.getBool(StorageKeys.twoFactAuth);
    this.log(data, tag: 'getTwoFactAuth');
    return data ?? false;
  }

  Future setAppLock(bool data) async {
    this.log(data, tag: 'setAppLock');
    final prefs = await getSharedPreferencesInstance();
    await prefs.setBool(StorageKeys.appLock, data);
  }

  Future<bool> getAppLock() async {
    final prefs = await getSharedPreferencesInstance();
    bool? data = await prefs.getBool(StorageKeys.appLock);
    this.log(data, tag: 'getAppLock');
    return data ?? false;
  }

  Future setRememberMe(bool data) async {
    this.log(data, tag: 'setRememberMe');
    final prefs = await getSharedPreferencesInstance();
    await prefs.setBool(StorageKeys.rememberMe, data);
  }

  Future<bool> getRememberMe() async {
    final prefs = await getSharedPreferencesInstance();
    bool? data = await prefs.getBool(StorageKeys.rememberMe);
    this.log(data, tag: 'getRememberMe');
    return data ?? false;
  }

  Future setLoginDetails(dynamic data) async {
    this.log(data, tag: 'setLoginDetails');
    final prefs = await getSharedPreferencesInstance();
    await prefs.setString(StorageKeys.loginDetails, jsonEncode(data));
  }

  Future<LoginDetails?> getLoginDetails() async {
    final prefs = await getSharedPreferencesInstance();
    String? data = await prefs.getString(StorageKeys.loginDetails) ?? null;
    this.log(data, tag: 'getLoginDetails');
    return data == null ? null : LoginDetails.fromJson(jsonDecode(data));
  }

  Future<bool> clearLoginDetails() async {
    final prefs = await getSharedPreferencesInstance();
    bool? data = await prefs.remove(StorageKeys.loginDetails);
    this.log(data, tag: 'clearLoginDetails');
    return data;
  }

  Future setEmployeeLoginDetail(dynamic data) async {
    this.log(data, tag: 'setEmployeeLoginDetail');
    final prefs = await getSharedPreferencesInstance();
    await prefs.setString(StorageKeys.employeeLoginDetail, jsonEncode(data));
  }

  Future<RemoteConfigData?> getRemoteConfigData() async {
    final prefs = await getSharedPreferencesInstance();
    String? data = await prefs.getString(StorageKeys.remoteConfigData) ?? null;
    this.log(data, tag: 'getRemoteConfigData');
    return data == null ? null : RemoteConfigData.fromJson(jsonDecode(data));
  }

  Future setRemoteConfigAppStatusData(dynamic data) async {
    this.log(data, tag: 'setRemoteConfigAppStatusData');
    final prefs = await getSharedPreferencesInstance();
    await prefs.setString(StorageKeys.remoteConfigAppStatusData, jsonEncode(data));
  }

  Future<RemoteConfigAppStatusData?> getRemoteConfigAppStatusData() async {
    final prefs = await getSharedPreferencesInstance();
    String? data = await prefs.getString(StorageKeys.remoteConfigAppStatusData) ?? null;
    this.log(data, tag: 'getRemoteConfigAppStatusData');
    return data == null ? null : RemoteConfigAppStatusData.fromJson(jsonDecode(data));
  }

  Future setRemoteConfigApiVersionsData(dynamic data) async {
    this.log(data, tag: 'setRemoteConfigApiVersionsData');
    final prefs = await getSharedPreferencesInstance();
    await prefs.setString(StorageKeys.remoteConfigData, jsonEncode(data));
  }

  Future<RemoteConfigApiVersionsData?> getRemoteConfigApiVersionsData() async {
    final prefs = await getSharedPreferencesInstance();
    String? data = await prefs.getString(StorageKeys.remoteConfigData) ?? null;
    this.log(data, tag: 'getRemoteConfigApiVersionsData');
    return data == null ? null : RemoteConfigApiVersionsData.fromJson(jsonDecode(data));
  }

  Future setLocationData(dynamic data) async {
    this.log(data, tag: 'setLocationData');
    final prefs = await getSharedPreferencesInstance();
    await prefs.setString(StorageKeys.locationData, jsonEncode(data));
  }

  Future<LocationDetails?> getLocationData() async {
    final prefs = await getSharedPreferencesInstance();
    String? data = await prefs.getString(StorageKeys.locationData) ?? null;
    this.log(data, tag: 'getLocationData');
    return data == null ? null : LocationDetails.fromJson(jsonDecode(data));
  }

  Future setDeviceInfo(dynamic data) async {
    this.log(data, tag: 'setDeviceInfo');
    final prefs = await getSharedPreferencesInstance();
    await prefs.setString(StorageKeys.deviceInfo, jsonEncode(data));
  }

  Future<DeviceInfo?> getDeviceInfo() async {
    final prefs = await getSharedPreferencesInstance();
    String? data = await prefs.getString(StorageKeys.deviceInfo) ?? null;
    this.log(data, tag: 'getDeviceInfo');
    return data == null ? null : DeviceInfo.fromJson(jsonDecode(data));
  }

  Future setLanguageDetails(dynamic data) async {
    this.log(data, tag: 'setLanguageDetails');
    final prefs = await getSharedPreferencesInstance();
    await prefs.setString(StorageKeys.languageDetails, jsonEncode(data));
  }

  Future<TranslationLanguage?> getLanguageDetails() async {
    final prefs = await getSharedPreferencesInstance();
    String? data = await prefs.getString(StorageKeys.languageDetails) ?? null;
    this.log(data, tag: 'getLanguageDetails');
    return data == null ? null : TranslationLanguage.fromJson(jsonDecode(data));
  }

  Future setNotificationStatus(dynamic data) async {
    this.log(data, tag: 'setNotificationStatus');
    final prefs = await getSharedPreferencesInstance();
    await prefs.setString(StorageKeys.notificationStatus, jsonEncode(data));
  }

  Future<NotificationsStatus?> getNotificationStatus() async {
    final prefs = await getSharedPreferencesInstance();
    String? data = await prefs.getString(StorageKeys.notificationStatus) ?? null;
    this.log(data, tag: 'getNotificationStatus');
    return data == null ? null : NotificationsStatus.fromJson(jsonDecode(data));
  }

  Future setTodaysShiftsDetails(dynamic data) async {
    this.log(data, tag: 'setTodaysShiftsDetails');
    final prefs = await getSharedPreferencesInstance();
    await prefs.setString(StorageKeys.todaysShiftsDetails, jsonEncode(data));
  }

  

  Future setDayShifts(dynamic data) async {
    this.log(data, tag: 'setDayShifts');
    final prefs = await getSharedPreferencesInstance();
    await prefs.setString(StorageKeys.dayShiftsList, jsonEncode(data));
  }


  Future setWeekShifts(dynamic data) async {
    this.log(data, tag: 'setWeekShifts');
    final prefs = await getSharedPreferencesInstance();
    await prefs.setString(StorageKeys.weekShiftsList, jsonEncode(data));
  }



  Future setMonthShifts(dynamic data) async {
    this.log(data, tag: 'setMonthShifts');
    final prefs = await getSharedPreferencesInstance();
    await prefs.setString(StorageKeys.monthShiftsList, jsonEncode(data));
  }



  Future setShiftsDetails(dynamic data) async {
    this.log(data, tag: 'setShiftsDetails');
    final prefs = await getSharedPreferencesInstance();
    await prefs.setString(StorageKeys.shiftDetails, jsonEncode(data));
  }



  Future setBackgroundLocationData(dynamic data) async {
    this.log(data, tag: 'setBackgroundLocationData');
    final prefs = await getSharedPreferencesInstance();
    await prefs.setStringList(StorageKeys.backgroundLocationData, data);
  }

  Future<List<BackgroundLocationLogs?>> getBackgroundLocationData() async {
    final prefs = await getSharedPreferencesInstance();
    List<String>? data = await prefs.getStringList(StorageKeys.backgroundLocationData);
    this.log(data, tag: 'getBackgroundLocationData');
    return BackgroundLocationLogs.listFromJson(data);
  }

  Future setRemindersListData(dynamic data) async {
    this.log(data, tag: 'setRemindersListData');
    final prefs = await getSharedPreferencesInstance();
    await prefs.setStringList(StorageKeys.remindersList, data);
  }

  Future<List<ReminderDetails>?> getRemindersListData() async {
    final prefs = await getSharedPreferencesInstance();
    List<String>? data = await prefs.getStringList(StorageKeys.remindersList);
    this.log(data, tag: 'getRemindersListData');
    return ReminderDetails.listFromJson(data);
  }

  Future clearEmpDetails() async {
    final prefs = await getSharedPreferencesInstance();
    final secureStorage = await getSecureStorageInstance();
    await prefs.remove(StorageKeys.employeeLoginDetail);
    await prefs.remove(StorageKeys.notificationStatus);
    await prefs.remove(StorageKeys.appLock);
    await secureStorage.deleteAll();
    return;
  }

  Future clearStorage() async {
    final prefs = await getSharedPreferencesInstance();
    return await prefs.clear();
  }
}

class HiveKeys {
  HiveKeys._privateConstructor();

  static const translationList = 'translation_list';
}

class SecureStorageKeys {
  SecureStorageKeys._privateConstructor();

  static const String tenantCode = 'tenant_code';
  static const String tenantCodeEncrypted = 'tenant_code_encrypted';
}

class StorageKeys {
  StorageKeys._privateConstructor();

  static const String remoteConfigData = 'remote_config_data';
  static const String remoteConfigAppStatusData = 'remote_config_app_status_data';
  static const String remoteConfigApiVersionsData = 'remote_config_api_versions_data';
  static const String locationData = 'location_data';
  static const String deviceInfo = 'device_info';
  static const String languageDetails = 'language_details';
  static const String notificationStatus = 'notification_status';
  static const String darkMode = 'dark_mode';
  static const String twoFactAuth = 'two_fact_auth';
  static const String appLock = 'app_lock';
  static const String backgroundLocationData = 'background_location_data';
  static const String loginDetails = 'login_details';
  static const String rememberMe = 'remember_me';

  static const String employeeLoginDetail = 'employee_login_details';
  static const String todaysShiftsDetails = 'todays_shifts_details';
  static const String dayShiftsList = 'day_shifts_list';
  static const String weekShiftsList = 'week_shifts_list';
  static const String monthShiftsList = 'month_shifts_list';
  static const String shiftDetails = 'shift_details';
  static const String remindersList = 'reminders_list';
}
