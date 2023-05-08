import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nnz/src/components/icon_data.dart';
import 'package:nnz/src/components/my_shared/my_shared_map.dart';
import 'package:nnz/src/config/config.dart';
import 'package:nnz/src/controller/shareingdetail_controller.dart';
import 'package:nnz/src/pages/user/mypage.dart';

class SharingDetailInfo extends StatelessWidget {
  final controller = Get.put(ShareDetailController());
  SharingDetailInfo({super.key});

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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              "나눔 위치",
              style: TextStyle(fontSize: 15, color: Config.blackColor),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          const MyMapWidget(),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              children: [
                const Image(
                  width: 20,
                  height: 20,
                  image: AssetImage(
                      "assets/images/sharing_sample/calendarcolor.png"),
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  "나눔 시간",
                  style: TextStyle(fontSize: 15, color: Config.blackColor),
                ),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 45, vertical: 15),
            child: Text(
              "2023. 01.01 16:30",
              style: TextStyle(fontSize: 16),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              children: [
                const Image(
                  width: 20,
                  height: 20,
                  image: AssetImage("assets/images/sharing_sample/clothes.png"),
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  "당일 착장",
                  style: TextStyle(fontSize: 15, color: Config.blackColor),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          const Padding(
            padding: EdgeInsets.only(left: 45),
            child: Text(
              "빨간색 체크셔츠를 입고있습니다",
              style: TextStyle(fontSize: 16),
            ),
          ),
          const SizedBox(
            height: 50,
          ),
        ],
      ),
    );
  }
}
