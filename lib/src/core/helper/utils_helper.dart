import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:image/image.dart' as img;
import 'package:loader_overlay/loader_overlay.dart';
import 'package:path/path.dart' as path;

import '../../app/app.dart';

class UtilsHelper {
  UtilsHelper._privateConstructor();

  static String getDateTimeWithTimeZoneOffset() {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('yyyy-MM-dd HH:mm:ss').format(now);
    String timeZoneOffset = now.timeZoneOffset.isNegative ? '-' : '+';
    String offsetHours = now.timeZoneOffset.inHours.abs().toString().padLeft(2, '0');
    String offsetMinutes = (now.timeZoneOffset.inMinutes.abs() % 60).toString().padLeft(2, '0');
    String formattedTimeZone = '$timeZoneOffset$offsetHours:$offsetMinutes';
    return '$formattedDate $formattedTimeZone';
  }

  static bool isToday(DateTime selectedDateTime) {
    DateTime currentDateTime = DateTime.now();
    return selectedDateTime.year == currentDateTime.year &&
        selectedDateTime.month == currentDateTime.month &&
        selectedDateTime.day == currentDateTime.day;
  }

  static Color colorFromHex(String? hexColor, {bool isText = false}) {
    if (hexColor != null) {
      if (hexColor == '#fff') return AppColors.light;
      final hexCode = hexColor.replaceAll('#', '');
      return Color(int.parse('0xFF$hexCode'));
    } else {
      return isText ? AppColors.gray.shade900 : AppColors.gray.withOpacity(.25);
    }
  }

  static DateTime convertStringToDateTime(String? dateStr) {
    if (dateStr == null) return DateTime.now();
    return DateFormat('yyyy-MM-dd').parse(dateStr);
  }

  static String convertDateTimeFormat(String? dateStr) {
    if (dateStr == null) return '';
    DateTime dateTime = DateFormat('yyyy-MM-dd HH:mm:ss').parse(dateStr);
    return DateFormat('d MMM, hh:mm a').format(dateTime);
  }

  static String convertTimeFormat(String? timeStr) {
    if (timeStr == null) return '';
    DateTime dateTime = DateFormat('HH:mm:ss').parse(timeStr);
    return DateFormat('h:mm a').format(dateTime);
  }

  static String convertDateFormat(String? dateStr) {
    if (dateStr == null) return '';
    DateTime dateTime = DateFormat('yyyy-MM-dd').parse(dateStr);
    return DateFormat('d MMM yyyy').format(dateTime);
  }

  static String convertToParsedDateFormat(DateTime? dateTime) {
    if (dateTime == null) return '';
    return DateFormat('yyyy-MM-dd').format(dateTime);
  }

  static String convertToParsedTimeFormat(TimeOfDay? timeOfDay) {
    if (timeOfDay == null) return '';
    final now = DateTime.now();
    final time = DateTime(now.year, now.month, now.day, timeOfDay.hour, timeOfDay.minute);
    return DateFormat('HH:mm:ss').format(time);
  }

  static Future<MultipartFile> platformFileToMultipartFile(PlatformFile platformFile) async {
    final file = File(platformFile.path ?? '');
    final fileSizeInBytes = await file.length();
    final fileSizeInMB = fileSizeInBytes / (1024 * 1024);

    print('PlatformFileToMultipartFile: ${fileSizeInMB.toStringAsFixed(2)} MB');

    // Check if the file is an image by its extension
    File processedFile = file;
    final fileExtension = path.extension(file.path).toLowerCase();
    final isImage = ['.jpg', '.jpeg', '.png', '.gif', '.bmp', '.webp'].contains(fileExtension);

    // Compress the image if it's an image and larger than 10 MB
    if (isImage && fileSizeInMB > 10) {
      print('Compressing image...');

      // Decode the image
      final image = img.decodeImage(await file.readAsBytes());
      if (image == null) {
        throw Exception('Failed to decode image');
      }

      // Set a target quality for compression
      final compressedBytes = img.encodeJpg(image, quality: 80);

      // Create a new file for the compressed image
      final compressedFilePath = path.join(path.dirname(file.path), 'compressed_${platformFile.name}');
      processedFile = await File(compressedFilePath).writeAsBytes(compressedBytes);

      // Check new file size
      final compressedFileSizeInBytes = await processedFile.length();
      final compressedFileSizeInMB = compressedFileSizeInBytes / (1024 * 1024);

      print('Compressed file size: ${compressedFileSizeInMB.toStringAsFixed(2)} MB');
    }

    return MultipartFile.fromFile(
      processedFile.path,
      filename: platformFile.name,
    );
  }

  static String getFileType(String? filePath) {
    if (filePath == null || filePath == '' || filePath.isEmpty) return 'unknow';
    String extension = path.extension(filePath).toLowerCase();
    if (['.jpg', '.jpeg', '.png'].contains(extension)) {
      return 'image';
    } else if (['.mp4', '.mov', '.mkv'].contains(extension)) {
      return 'video';
    } else {
      return 'unknown';
    }
  }

  static String getFileExtension(String? filePath) {
    if (filePath == null || filePath == '' || filePath.isEmpty) return 'unknow';
    String extension = path.extension(filePath).toLowerCase();
    return extension;
  }

  static String? getFileNameFromUrl(String? url) {
    if (url == null) return 'Document_${DateTime.now.toString()}';
    final filePath = url.split('/').last;
    final fileNameWithExtension = filePath.split('?').first;
    return fileNameWithExtension;
  }
}

extension IterableExtension<T> on Iterable<T> {
  T? firstWhereOrNullCustom(bool Function(T element) test) {
    for (var element in this) {
      if (test(element)) return element;
    }
    return null;
  }
}

/// Extensions on [String].
extension StringExtension on String {
  /// Returns initials for a string
  String initials() {
    var parts = split(' ')..removeWhere((e) => e == '');

    if (parts.length > 2) {
      parts = parts.take(2).toList();
    }

    final resultBuffer = StringBuffer();

    for (var i = 0; i < parts.length; i++) {
      resultBuffer.write(parts[i][0].toUpperCase());
    }

    return resultBuffer.toString();
  }

  bool equalsIgnoreCase(String other) => toUpperCase() == other.toUpperCase();
}

extension StringExtensions on String? {
  bool get hasValue => this != null && this!.isNotEmpty && this != '-';
}

extension Loader on BuildContext {
  void loader(bool isLoading) => isLoading ? showLoader() : hideLoader();

  void showLoader() => this.loaderOverlay.show();

  void hideLoader() => this.loaderOverlay.hide();
}

extension EmailValidator on String {
  bool isValidEmail() {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(this);
  }
}

extension ScreenSizeExtension on BuildContext {
  double get screenWidth => MediaQuery.of(this).size.width;
  double get screenHeight => MediaQuery.of(this).size.height;
}

extension TabletDevice on BuildContext {
  bool get isTablet => MediaQuery.of(this).size.width > 620;
}

bool convertIntToBool(int? value) {
  return value == 1 ? true : false;
}

class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    return TextEditingValue(
      text: newValue.text.toUpperCase(),
      selection: newValue.selection,
    );
  }
}
