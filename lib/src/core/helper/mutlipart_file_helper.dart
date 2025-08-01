import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';

class MultipartFileExtension {
  final List<int>? bytes;
  final String? filename;
  final MediaType? contentType;

  MultipartFileExtension({
    this.bytes,
    this.filename,
    this.contentType,
  });

  static MultipartFile fromJson(Map<String, dynamic> json) {
    return MultipartFile.fromBytes(
      List<int>.from(json['bytes']),
      filename: json['filename'],
      contentType: json['contentType'] != null ? MediaType.parse(json['contentType']) : null,
    );
  }

  static Map<String, dynamic> toJson(MultipartFile file) {
    return {
      'bytes': file.finalize().toList(),
      'filename': file.filename,
      'contentType': file.contentType?.toString(),
    };
  }

  MultipartFile toMultipartFile() {
    return MultipartFile.fromBytes(
      bytes ?? [],
      filename: filename,
      contentType: contentType,
    );
  }
}
