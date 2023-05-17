import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nnz/src/components/icon_data.dart';
import 'package:nnz/src/config/config.dart';
import 'package:http/http.dart' as http;
import 'package:nnz/src/config/token.dart';
import 'package:nnz/src/model/share_stock_model.dart';
import 'package:nnz/src/pages/user/mypage.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class ShareQrLeader extends StatefulWidget {
  const ShareQrLeader({super.key, required this.nanumIds});
  final int nanumIds;

  @override
  State<ShareQrLeader> createState() => _ShareQrLeaderState();
}

class _ShareQrLeaderState extends State<ShareQrLeader> {
  Rx<Map<dynamic, dynamic>> result = Rx<Map<dynamic, dynamic>>({});

  final GlobalKey qrKey = GlobalKey();
  QRViewController? controller;
  Barcode? resultt;
  int receiveId = 17;
  bool isCameraActive = false;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  void qr(QRViewController controller) async {
    String? token;
    token = await Token.getAccessToken();
    this.controller = controller;
    controller.scannedDataStream.listen((event) async {
      var res = await http.post(
        Uri.parse(
          "https://k8b207.p.ssafy.io/api/nanum-service/nanums/${widget.nanumIds}/qr/${event.code}",
        ),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );
      setState(() {
        resultt = event;
      });

      // QR 코드를 한 번 읽으면 카메라를 일시 정지
      controller.pauseCamera();
      _refreshData();
      setState(() {
        isCameraActive = false;
      });
    });
  }

  void fetchData() async {
    String? token;
    token = await Token.getAccessToken();
    var res = await http.get(
        Uri.parse(
            "https://k8b207.p.ssafy.io/api/nanum-service/nanums/${widget.nanumIds}/quantity"),
        headers: {
          'Authorization': 'Bearer $token',
          "Accept-Charset": "utf-8",
        });

    ShareStockModel shareStockModelclass =
        ShareStockModel.fromJson(jsonDecode(res.body));
    result.value = jsonDecode(utf8.decode(res.bodyBytes));
    print("재고체크");
    print(result.value);

    setState(() {
      result.value = jsonDecode(utf8.decode(res.bodyBytes));
    });
  }

  void _refreshData() {
    fetchData();
  }

  void toggleCamera() {
    setState(() {
      isCameraActive = !isCameraActive;
    });

    if (isCameraActive) {
      controller?.resumeCamera();
    } else {
      controller?.pauseCamera();
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
        leading: IconButton(
          icon: const Icon(Icons.account_circle),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const MyPage()),
            );
          },
        ),
        title: Center(child: Image.asset(ImagePath.logo, width: 80)),
        actions: const [Icon(Icons.notifications)],
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          SizedBox(
            width: double.infinity,
            height: 400,
            child: Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  height: 300,
                  child: QRView(
                    key: qrKey,
                    onQRViewCreated: qr,
                  ),
                ),
                ElevatedButton(
                  onPressed: toggleCamera,
                  child: Text(isCameraActive ? '카메라 정지' : '카메라 시작'),
                ),
                Center(
                  child: (resultt != null)
                      ? Text('${resultt!.code}')
                      : const Text("다음 스캔을 진행해주세요"),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 35),
            child: Container(
              height: 80,
              width: double.infinity,
              decoration: BoxDecoration(color: Config.yellowColor),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        const SizedBox(
                          height: 5,
                        ),
                        const Text(
                          "전체 수량",
                          style: TextStyle(color: Colors.grey, fontSize: 14),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          "${result.value["quantity"]}",
                          style: const TextStyle(fontSize: 30),
                        )
                      ],
                    ),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey,
                          width: 0.1,
                        ),
                      ),
                    ),
                    Column(
                      children: [
                        const SizedBox(
                          height: 5,
                        ),
                        const Text(
                          "남은 수량",
                          style: TextStyle(color: Colors.grey, fontSize: 14),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          "${result.value["stock"]}",
                          style: const TextStyle(fontSize: 30),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
