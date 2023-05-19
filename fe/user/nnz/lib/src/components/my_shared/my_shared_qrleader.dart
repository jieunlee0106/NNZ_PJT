// import 'package:flutter/material.dart';
// import 'package:qr_code_scanner/qr_code_scanner.dart';
// import 'package:http/http.dart' as http;

// class QRLeader extends StatefulWidget {
//   const QRLeader({super.key});

//   @override
//   State<QRLeader> createState() => _QRLeaderState();
// }

// class _QRLeaderState extends State<QRLeader> {
//   final GlobalKey qrKey = GlobalKey();
//   QRViewController? controller;
//   Barcode? result;
//   int nanumId = 71;
//   int receiveId = 17;
//   bool isCameraActive = false;

//   void qr(QRViewController controller) {
//     this.controller = controller;
//     controller.scannedDataStream.listen((event) async {
//       var res = await http.post(
//         Uri.parse(
//           "https://k8b207.p.ssafy.io/api/nanum-service/nanums/$nanumId/qr/${event.code}",
//         ),
//         headers: {
//           'Authorization':
//               'Bearer eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiIyIiwiaXNzIjoibm56IiwiaWF0IjoxNjg0MDY5NjYzLCJhdXRoUHJvdmlkZXIiOiJOTloiLCJyb2xlIjoiQURNSU4iLCJpZCI6MiwiZW1haWwiOiJzc2FmeTAwMUBzc2FmeS5jb20iLCJleHAiOjE2ODUzNjU2NjN9.tPkq_vcxjmyYlXg8ovvCD4JTBtkIA975OtBQcKmqZZrTHExCEvTsYL9V8iJ6dL64FDyHPde4C1U-cWh-l69ksA',
//         },
//       );
//       setState(() {
//         result = event;
//       });

//       // QR 코드를 한 번 읽으면 카메라를 일시 정지
//       controller.pauseCamera();
//       setState(() {
//         isCameraActive = false;
//       });
//     });
//   }

//   void toggleCamera() {
//     setState(() {
//       isCameraActive = !isCameraActive;
//     });

//     if (isCameraActive) {
//       controller?.resumeCamera();
//     } else {
//       controller?.pauseCamera();
//     }
//   }

//   @override
//   void dispose() {
//     controller?.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         SizedBox(
//           width: double.infinity,
//           height: 300,
//           child: QRView(
//             key: qrKey,
//             onQRViewCreated: qr,
//           ),
//         ),
//         ElevatedButton(
//           onPressed: toggleCamera,
//           child: Text(isCameraActive ? '카메라 정지' : '카메라 시작'),
//         ),
//         Center(
//           child: (result != null)
//               ? Text('${result!.code}')
//               : const Text("다음 스캔을 진행해주세요"),
//         ),
//       ],
//     );
//   }
// }
