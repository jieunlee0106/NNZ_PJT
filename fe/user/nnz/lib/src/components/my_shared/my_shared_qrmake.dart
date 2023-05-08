import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class MyShareQr extends StatelessWidget {
  const MyShareQr({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 80,
        ),
        const Text("QR코드를 찍어주세요"),
        QrImage(
          data: "사용자 아이디값을 보내는데 이거 보안은?",
          version: QrVersions.auto,
          size: 150,
          errorStateBuilder: (context, error) {
            return const Center(
              child: Text("유효하지 않은 사용자입니다"),
            );
          },
        )
      ],
    );
  }
}
