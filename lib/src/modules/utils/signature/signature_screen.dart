import 'dart:ui' as ui;

import 'package:syncfusion_flutter_signaturepad/signaturepad.dart';

import '../../../app/app.dart';

class SignatureScreen extends StatefulWidget {
  const SignatureScreen({Key? key}) : super(key: key);

  @override
  _SignatureScreenState createState() => _SignatureScreenState();
}

class _SignatureScreenState extends State<SignatureScreen> {
  GlobalKey<SfSignaturePadState> _signaturePadKey = GlobalKey();

  void saveImage() async {
    final data = await _signaturePadKey.currentState!.toImage(pixelRatio: 3.0);
    final bytes = await data.toByteData(format: ui.ImageByteFormat.png);
    _signaturePadKey.currentState?.clear();
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) {
          return Scaffold(
            appBar: AppBar(
              title: Text('Image'),
            ),
            body: CommonCard(
              margin: EdgeInsets.all(16),
              padding: EdgeInsets.zero,
              child: Image.memory(bytes!.buffer.asUint8List()),
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppTrKeys.signature.tr(context)),
      ),
      body: Column(
        children: [
          CommonCard(
            margin: EdgeInsets.all(16),
            padding: EdgeInsets.zero,
            child: SfSignaturePad(
              key: _signaturePadKey,
            ),
          ),
          CommonFilledButton(
            isHalfWidth: true,
            margin: EdgeInsets.all(16).copyWith(top: 0),
            label: 'Save',
            onPressed: saveImage,
          ),
        ],
      ),
    );
  }
}
