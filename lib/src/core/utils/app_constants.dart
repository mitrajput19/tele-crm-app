class AppConstants {
  AppConstants._privateConstructor();

  static const String firebaseServerKey =
      'ya29.a0AXooCgtUbxllnpUb54-TwStyXx69GJzya_8d3N3ons07DHKQNitikVBRAaziFyRAUR_1lt3Z8nvNht1HpvUFmZZWCQjjAKOOWEPGi9E_QZpHndh-c9IelzheALQOM4umU3-MjqUGLJkwL96PzNs9Q0luP-Nt_LI7e85_QAaCgYKAeoSARESFQHGX2MiXJBUIZ3LbZyNJgHQ5922SA0173';
  static const String darkModeMapJsonAsset = 'assets/google_map_dark_mode.json';

  static const String generalNotificationTopic = 'general';
  static const String shiftNotificationTopic = 'shift';
  static const String taskNotificationTopic = 'task';
  static const String chatNotificationTopic = 'chat';
}

enum AppNotificationTopicTypes {
  OffAll,
  General,
  Shift,
  Task,
  Chat,
}

class ShiftEventTypes {
  static const String clockIn = 'CLOCK_IN';
  static const String clockOut = 'CLOCK_OUT';
  static const String breakStart = 'BREAK_START';
  static const String breakEnd = 'BREAK_END';
  static const String available = 'AVAILABLE';
  static const String unAvailable = 'UNAVAILABLE';
}
