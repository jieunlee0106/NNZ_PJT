import 'package:flutter/material.dart';
import 'package:nnz/src/app.dart';
import 'package:nnz/src/config/config.dart';
import 'package:get/get.dart';
import 'package:nnz/src/pages/share/share_detail.dart';

class SharingComplete extends StatelessWidget {
  const SharingComplete({super.key, required this.nanumIds});
  final int nanumIds;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
        leading: const Icon(Icons.account_circle),
        actions: const [Icon(Icons.notifications)],
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(
              height: 80,
            ),
            const Text("나눔 신청이 성공했습니다!"),
            const SizedBox(
              height: 300,
              width: 300,
              child: Image(
                  image: AssetImage(
                      "assets/images/sharing_sample/successShare.gif")),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: GestureDetector(
                onTap: () => Get.to(() => ShareDatail(
                      nanumIds: nanumIds,
                    )),
                child: Container(
                  decoration: BoxDecoration(
                      color: Config.yellowColor,
                      borderRadius: BorderRadius.circular(5)),
                  width: double.maxFinite,
                  child: const Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Text(
                        "나눔으로 돌아가기",
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: GestureDetector(
                onTap: () => Get.to(() => const App()),
                child: Container(
                  decoration: BoxDecoration(
                      color: Config.yellowColor,
                      borderRadius: BorderRadius.circular(5)),
                  width: double.maxFinite,
                  child: const Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Text(
                        "홈으로",
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
      backgroundColor: Colors.white,
    );
  }
}
