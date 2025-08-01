class AppConstants {
  AppConstants._privateConstructor();

  static const String firebaseServerKey =
      'ya29.a0AXooCgtUbxllnpUb54-TwStyXx69GJzya_8d3N3ons07DHKQNitikVBRAaziFyRAUR_1lt3Z8nvNht1HpvUFmZZWCQjjAKOOWEPGi9E_QZpHndh-c9IelzheALQOM4umU3-MjqUGLJkwL96PzNs9Q0luP-Nt_LI7e85_QAaCgYKAeoSARESFQHGX2MiXJBUIZ3LbZyNJgHQ5922SA0173';
  static const String darkModeMapJsonAsset = 'assets/google_map_dark_mode.json';
  static const String supabaseUrl = 'https://imjlrlyjtjcizfrtyhxe.supabase.co';
  static const String supabaseAnonKey = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImltamxybHlqdGpjaXpmcnR5aHhlIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTMwNzA4ODQsImV4cCI6MjA2ODY0Njg4NH0.j2lzZSWIm_s3pdyaS5eN7Hb7U4qROqAkThqRscQ7t8g';

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
