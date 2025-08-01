// import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

// import '../../../app/app.dart';

// class ScannerScreen extends StatefulWidget {
//   const ScannerScreen({Key? key}) : super(key: key);

//   @override
//   _ScannerScreenState createState() => _ScannerScreenState();
// }

// class _ScannerScreenState extends State<ScannerScreen> {
//   final scannerTextController = TextEditingController();

//   void openScanner() async {
//     String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
//       '#000000',
//       'Cancel',
//       false,
//       ScanMode.DEFAULT,
//     );
//     scannerTextController.text = barcodeScanRes;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(AppTrKeys.scanner.tr(context)),
//       ),
//       body: Container(
//         margin: EdgeInsets.all(16),
//         child: Column(
//           children: [
//             Row(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 Expanded(
//                   child: CommonTextField(
//                     hasLabel: false,
//                     hasBottomSpacing: false,
//                     controller: scannerTextController,
//                   ),
//                 ),
//                 SizedBox(width: 16),
//                 CommonIcon(
//                   Icons.qr_code,
//                   color: AppColors.light,
//                   padding: EdgeInsets.all(8),
//                   backgroundColor: AppColors.lightPrimary,
//                   onTap: openScanner,
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
