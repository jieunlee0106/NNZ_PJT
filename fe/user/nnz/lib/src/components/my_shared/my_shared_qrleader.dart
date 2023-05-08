import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QRLeader extends StatefulWidget {
  const QRLeader({super.key});

  @override
  State<QRLeader> createState() => _QRLeaderState();
}

class _QRLeaderState extends State<QRLeader> {
  final GlobalKey _globalKey = GlobalKey();
  QRViewController? controller;
  Barcode? result;
  void qr(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((event) {
      setState(() {
        result = event;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          height: 300,
          child: QRView(
            key: _globalKey,
            onQRViewCreated: qr,
          ),
        ),
        Center(
          child: (result != null)
              ? Text('${result!.code}')
              : const Text("다음 스캔을 진행해주세요"),
        )
      ],
    );
  }
}
