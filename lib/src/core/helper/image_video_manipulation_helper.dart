// import 'dart:io';
// import 'dart:math' as math;
// import 'dart:ui' as ui;

// import 'package:ffmpeg_kit_flutter/ffmpeg_kit.dart';
// import 'package:ffmpeg_kit_flutter/ffmpeg_kit_config.dart';
// import 'package:ffmpeg_kit_flutter/log.dart';
// import 'package:ffmpeg_kit_flutter/return_code.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:path_provider/path_provider.dart';

// class ImageVideoManipulationHelper {
//   static Future<XFile> addTextToVideo(XFile videoFile, String timeStamp) async {
//     try {
//       if (Platform.isIOS) {
//         return await addTextToVideoIOS(videoFile, timeStamp);
//       } else {
//         return await addTextToVideoAndriod(videoFile, timeStamp);
//       }
//     } catch (e) {
//       print('Detailed error in addTextToVideo: $e');
//       rethrow;
//     }
//   }

//   static Future<XFile> addTextToVideoIOS(XFile videoFile, String timeStamp) async {
//     try {
//       final Directory tempDir = await getTemporaryDirectory();
//       final String convertedPath = '${tempDir.path}/converted_${DateTime.now().millisecondsSinceEpoch}.mp4';
//       final String finalOutputPath = '${tempDir.path}/output_video_${DateTime.now().millisecondsSinceEpoch}.mp4';

//       // Convert MOV to MP4 only on iOS
//       if (Platform.isIOS && videoFile.path.toLowerCase().endsWith('.mov')) {
//         print('Converting MOV to MP4 on iOS...');

//         final List<String> convertArgs = [
//           '-i',
//           videoFile.path,
//           '-c:v',
//           'libx264',
//           '-crf',
//           '23',
//           '-preset',
//           'medium',
//           '-c:a',
//           'aac',
//           '-strict',
//           'experimental',
//           '-b:a',
//           '128k',
//           '-movflags',
//           '+faststart',
//           convertedPath
//         ];

//         final convertSession = await FFmpegKit.executeWithArguments(convertArgs);
//         final convertReturnCode = await convertSession.getReturnCode();

//         if (!ReturnCode.isSuccess(convertReturnCode)) {
//           final convertLogs = await convertSession.getLogs();
//         }

//         videoFile = XFile(convertedPath);
//       }

//       String dateTime = timeStamp.replaceAll("'", "'\\''").replaceAll(':', '\\:');

//       // Add text to video
//       final String ffmpegCommand = '-i "${videoFile.path}" '
//           '-c:v libx264 '
//           '-preset fast '
//           '-crf 23 '
//           '-vf "drawtext=text=\'$dateTime Video\''
//           ':fontsize=40:fontcolor=yellow:box=1:boxcolor=black@0.5:boxborderw=10:x=40:y=h-th-40" '
//           '-c:a aac '
//           '-movflags +faststart '
//           '"$finalOutputPath"';

//       print('Input path: ${videoFile.path}');
//       print('Final output path: $finalOutputPath');
//       print('FFmpeg arguments: ${ffmpegCommand}');

//       final session = await FFmpegKit.execute(ffmpegCommand);
//       final returnCode = await session.getReturnCode();
//       final logs = await session.getLogs();

//       for (Log log in logs) {
//         print('FFmpeg Log: ${log.getMessage()}');
//       }

//       if (ReturnCode.isSuccess(returnCode)) {
//         File outputFile = File(finalOutputPath);
//         if (await outputFile.exists()) {
//           print('Successfully created video at: $finalOutputPath');

//           // Move to documents directory for persistence
//           final Directory docDir = await getApplicationDocumentsDirectory();
//           final String persistentPath = '${docDir.path}/final_video_${DateTime.now().millisecondsSinceEpoch}.mp4';
//           await outputFile.copy(persistentPath);

//           // Clean up temporary files
//           await outputFile.delete();
//           if (videoFile.path == convertedPath) await File(convertedPath).delete();

//           return XFile(persistentPath);
//         } else {
//           throw Exception('Output file was not created at: $finalOutputPath');
//         }
//       } else {
//         final session_state = await session.getState();
//         final failure_stack = await session.getFailStackTrace();
//         final error_logs = logs.length > 0 ? logs.map((log) => log.getMessage()).join('\n') : 'No logs available';

//         throw Exception('''FFmpeg process failed.
//         State: ${session_state}
//         Failure Stack: ${failure_stack}
//         Error logs: ${error_logs}''');
//       }
//     } catch (e) {
//       print('Detailed error in addTextToVideo: $e');
//       rethrow;
//     } finally {
//       // Cleanup temporary files
//       try {
//         final tempDir = await getTemporaryDirectory();
//         final tempFiles = await tempDir
//             .list()
//             .where((entity) => entity.path.contains('converted_') || entity.path.contains('output_video_'))
//             .toList();

//         for (var file in tempFiles) await file.delete();
//       } catch (e) {
//         print('Error during cleanup: $e');
//       }
//     }
//   }

//   static Future<XFile> addTextToVideoAndriod(XFile videoFile, String timeStamp) async {
//     try {
//       // Get the application documents directory and create output path
//       final Directory appDir = await getApplicationDocumentsDirectory();
//       final String outputPath = '${appDir.path}/outputvideo${DateTime.now().millisecondsSinceEpoch}.mp4';

//       String dateTime = timeStamp.replaceAll("'", "'\\''").replaceAll(':', '\\:');

//       // Build FFmpeg command with explicit input and output paths
//       final String ffmpegCommand = '-i "${videoFile.path}" '
//           '-c:v libx264 '
//           '-preset fast '
//           '-crf 23 '
//           '-vf "drawtext=text=\'$dateTime Video\''
//           ':fontsize=40:fontcolor=yellow:box=1:boxcolor=black@0.5:boxborderw=10:x=40:y=h-th-40" '
//           '-c:a aac '
//           '-movflags +faststart '
//           '"$outputPath"';

//       print('DateTime text : $timeStamp');
//       print('Input path: ${videoFile.path}');
//       print('Output path: $outputPath');
//       print('FFmpeg command: $ffmpegCommand');

//       // Execute FFmpeg command
//       await FFmpegKitConfig.setFontDirectory('/system/fonts');
//       final session = await FFmpegKit.execute(ffmpegCommand);
//       final returnCode = await session.getReturnCode();
//       final logs = await session.getLogs();
//       await FFmpegKit.cancel();

//       // Log all FFmpeg output
//       for (Log log in logs) print('FFmpeg Log: ${log.getMessage()}');

//       if (ReturnCode.isSuccess(returnCode)) {
//         File outputFile = File(outputPath);
//         if (await outputFile.exists()) {
//           print('Successfully created video at: $outputPath');
//           return XFile(outputPath);
//         } else {
//           throw Exception('Output file was not created at: $outputPath');
//         }
//       } else {
//         // Get the last few error logs
//         String errorLogs = logs.length > 0 ? logs.map((log) => log.getMessage()).join('\n') : 'No logs available';
//         throw Exception('FFmpeg process failed. Error logs:\n$errorLogs');
//       }
//     } catch (e) {
//       print('Detailed error in addTextToVideo: $e');
//       rethrow;
//     }
//   }

//   static Future<XFile> addTextToImage(XFile imageFile, String text) async {
//     // Read image
//     final bytes = await imageFile.readAsBytes();
//     final codec = await ui.instantiateImageCodec(bytes);
//     final image = (await codec.getNextFrame()).image;

//     final recorder = ui.PictureRecorder();
//     final canvas = Canvas(recorder);

//     // Calculate dynamic font size based on image dimensions
//     // Using the smaller dimension (width or height) to ensure text fits
//     final smallerDimension = math.min(image.width, image.height);
//     // Font size will be approximately 5% of the smaller dimension
//     final fontSize = smallerDimension * 0.04;
//     final finalText = '$text Image';

//     // Draw original image
//     canvas.drawImage(image, Offset.zero, Paint());

//     // First create a TextPainter to measure the text size
//     final measurePainter = TextPainter(
//       textDirection: TextDirection.ltr,
//       text: TextSpan(
//         text: finalText,
//         style: TextStyle(fontSize: fontSize),
//       ),
//     )..layout();

//     // Ensure text doesn't overflow image width
//     final maxWidth = image.width - 40;
//     double actualFontSize = fontSize;

//     // If text is too wide, reduce font size until it fits
//     if (measurePainter.width > maxWidth) {
//       actualFontSize = fontSize * (maxWidth / measurePainter.width);
//     }

//     // Calculate position (bottom left with padding)
//     final position = Offset(40, image.height - measurePainter.height - 40);

//     // Draw the black box first
//     final boxWidth = measurePainter.width + 40;
//     final boxHeight = measurePainter.height + 40;
//     final boxPosition = Offset(position.dx - 20, position.dy - 20);

//     canvas.drawRect(
//       Rect.fromLTWH(boxPosition.dx, boxPosition.dy, boxWidth, boxHeight),
//       Paint()
//         ..color = Colors.black.withOpacity(0.5)
//         ..style = PaintingStyle.fill,
//     );

//     // Then draw the yellow text on top
//     TextPainter(
//       textDirection: TextDirection.ltr,
//       text: TextSpan(
//         text: finalText,
//         style: TextStyle(
//           fontSize: actualFontSize,
//           color: Colors.yellow,
//         ),
//       ),
//     )
//       ..layout()
//       ..paint(canvas, position);

//     // Save and return the new image
//     final finalImage = await recorder.endRecording().toImage(image.width, image.height);
//     final byteData = await finalImage.toByteData(format: ui.ImageByteFormat.png);
//     final Directory appDir = await getApplicationDocumentsDirectory();
//     final String outputPath = '${appDir.path}/output_image_${DateTime.now().millisecondsSinceEpoch}.png';
//     await File(outputPath).writeAsBytes(byteData!.buffer.asUint8List());

//     return XFile(outputPath);
//   }

//   // static Future<XFile> addTextToImage(XFile imageFile, String text) async {
//   //   // Read image
//   //   final bytes = await imageFile.readAsBytes();
//   //   final codec = await ui.instantiateImageCodec(bytes);
//   //   final image = (await codec.getNextFrame()).image;

//   //   final recorder = ui.PictureRecorder();
//   //   final canvas = Canvas(recorder);

//   //   // Calculate dynamic font size based on image dimensions
//   //   // Using the smaller dimension (width or height) to ensure text fits
//   //   final smallerDimension = math.min(image.width, image.height);
//   //   // Font size will be approximately 5% of the smaller dimension
//   //   final fontSize = smallerDimension * 0.05;
//   //   final finalText = '$text Image';

//   //   // Draw original image
//   //   canvas.drawImage(image, Offset.zero, Paint());

//   //   // First create a TextPainter to measure the text size
//   //   final measurePainter = TextPainter(
//   //     textDirection: TextDirection.ltr,
//   //     text: TextSpan(
//   //       text: finalText,
//   //       style: TextStyle(fontSize: fontSize),
//   //     ),
//   //   )..layout();

//   //   // Ensure text doesn't overflow image width
//   //   final maxWidth = image.width - 40; // 40 pixels total padding (20 on each side)
//   //   double actualFontSize = fontSize;

//   //   // If text is too wide, reduce font size until it fits
//   //   if (measurePainter.width > maxWidth) {
//   //     actualFontSize = fontSize * (maxWidth / measurePainter.width);
//   //   }

//   //   // Calculate position (bottom left with padding)
//   //   final position = Offset(20, image.height - measurePainter.height - 20);

//   //   // Draw the border first
//   //   TextPainter(
//   //     textDirection: TextDirection.ltr,
//   //     text: TextSpan(
//   //       text: finalText,
//   //       style: TextStyle(
//   //         fontSize: actualFontSize,
//   //         foreground: Paint()
//   //           ..style = PaintingStyle.stroke
//   //           ..strokeWidth = actualFontSize * 0.13 // Make stroke width proportional to font size
//   //           ..color = Colors.black,
//   //       ),
//   //     ),
//   //   )
//   //     ..layout()
//   //     ..paint(canvas, position);

//   //   // Then draw the fill on top
//   //   TextPainter(
//   //     textDirection: TextDirection.ltr,
//   //     text: TextSpan(
//   //       text: finalText,
//   //       style: TextStyle(
//   //         fontSize: actualFontSize,
//   //         color: Colors.yellow,
//   //       ),
//   //     ),
//   //   )
//   //     ..layout()
//   //     ..paint(canvas, position);

//   //   // Save and return the new image
//   //   final finalImage = await recorder.endRecording().toImage(image.width, image.height);
//   //   final byteData = await finalImage.toByteData(format: ui.ImageByteFormat.png);
//   //   final Directory appDir = await getApplicationDocumentsDirectory();
//   //   final String outputPath = '${appDir.path}/output_image_${DateTime.now().millisecondsSinceEpoch}.png';
//   //   await File(outputPath).writeAsBytes(byteData!.buffer.asUint8List());

//   //   return XFile(outputPath);
//   // }
// }
