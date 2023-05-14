import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nnz/src/components/icon_data.dart';
import 'package:nnz/src/components/my_shared/my_shared_infocard.dart';
import 'package:nnz/src/components/sharing_detail/divide_line.dart';
import 'package:nnz/src/components/sharing_detail/sharing_button.dart';
import 'package:nnz/src/controller/list_scroll_controller.dart';
import 'package:nnz/src/pages/share/my_shared_auth.dart';
import 'package:nnz/src/pages/share/my_shared_info.dart';
import 'package:nnz/src/pages/share/my_shared_list.dart';
import 'package:nnz/src/pages/share/my_shared_qrleader.dart';
import 'package:nnz/src/pages/user/mypage.dart';

class MySharedDetail extends StatelessWidget {
  MySharedDetail({super.key});

  final scrollControlloer = Get.put(InfiniteScrollController());

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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            const MySharedCard(),
            const SizedBox(
              height: 5,
            ),
            const DevideLine(
              bgColor: Color(0xFFF3C906),
              pad: 0,
            ),
            const SizedBox(
              height: 7,
            ),
            Row(
              children: [
                GestureDetector(
                  onTap: () => Get.to(() => MySharedInfo()),
                  child: const SharingButton(
                      btnheight: 10, btnwidth: 53, btntext: "당일 정보 입력"),
                ),
                const SizedBox(
                  width: 10,
                ),
                GestureDetector(
                  onTap: () => Get.to(() => const ShareQrLeader()),
                  child: const SharingButton(
                      btnheight: 11, btnwidth: 82, btntext: "QR"),
                )
              ],
            ),
            const SizedBox(
              height: 50,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "참가 인원",
                  style: TextStyle(fontSize: 14),
                ),
                GestureDetector(
                  onTap: () => Get.to(() => const SharedAuthCheck()),
                  child: const Row(
                    children: [
                      Text("인증 확인"),
                      Icon(Icons.arrow_forward),
                    ],
                  ),
                ),
              ],
            ),
            const MySharedList()
          ],
        ),
      ),
    );
  }
}
