import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nnz/src/components/icon_data.dart';
import 'package:nnz/src/components/sharing_detail/divide_line.dart';
import 'package:nnz/src/components/sharing_detail/perform_detail.dart';
import 'package:nnz/src/components/sharing_detail/sharing_button.dart';
import 'package:nnz/src/config/config.dart';
import 'package:nnz/src/controller/list_scroll_controller.dart';
import 'package:nnz/src/pages/share/my_shared_auth.dart';
import 'package:nnz/src/pages/share/my_shared_info.dart';
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
            Row(
              children: [
                Text(
                  "백예린 스티커 무료나눔합니다.",
                  style: TextStyle(
                    fontSize: 18,
                    color: Config.blackColor,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            const Row(
              children: [
                PerformDetail(
                  performTitle: "올림픽 공원",
                  iconName: Icons.room,
                  textSize: 12,
                ),
                SizedBox(
                  width: 12,
                ),
                PerformDetail(
                    performTitle: "2023.01.01",
                    iconName: Icons.calendar_month,
                    textSize: 12),
              ],
            ),
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
            Expanded(
              child: Obx(
                () => Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: ListView.separated(
                    controller: scrollControlloer.scrollController.value,
                    itemBuilder: (_, index) {
                      if (index < scrollControlloer.data.length) {
                        var datum = scrollControlloer.data[index];
                        return Material(
                          elevation: 3.0,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            child: ListTile(
                              leading: Container(
                                width: 40,
                                height: 40,
                                decoration: const BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage(
                                        "assets/images/sharing_sample/profileimage.jpg"),
                                    fit: BoxFit.cover,
                                  ),
                                  shape: BoxShape.circle,
                                ),
                              ),
                              title: Text('$datum번 인증자'),
                              trailing: Container(
                                width: 30,
                                height: 30,
                                decoration: const BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage(
                                        "assets/images/sharing_sample/pass.png"),
                                    fit: BoxFit.cover,
                                  ),
                                  shape: BoxShape.circle,
                                ),
                              ),
                            ),
                          ),
                        );
                      }

                      if (scrollControlloer.hasMore.value ||
                          scrollControlloer.isLoading.value) {
                        return const Center(child: RefreshProgressIndicator());
                      }

                      return Container(
                        padding: const EdgeInsets.all(10.0),
                        child: Center(
                          child: Column(
                            children: [
                              const Text('데이터의 마지막 입니다'),
                              IconButton(
                                onPressed: () {
                                  scrollControlloer.reload();
                                },
                                icon: const Icon(Icons.refresh_outlined),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (_, index) => const Divider(),
                    itemCount: scrollControlloer.data.length + 1,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
