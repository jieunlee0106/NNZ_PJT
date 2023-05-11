import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nnz/src/components/icon_data.dart';
import 'package:nnz/src/components/my_shared/my_shared_map.dart';
import 'package:nnz/src/components/my_shared/my_shared_timepicker.dart';
import 'package:nnz/src/components/sharing_detail/sharing_button.dart';
import 'package:nnz/src/config/config.dart';
import 'package:nnz/src/controller/myshared_info_controller.dart';
import 'package:nnz/src/controller/shareingdetail_controller.dart';
import 'package:nnz/src/pages/user/mypage.dart';

class MySharedInfoForm extends StatelessWidget {
  final controller = Get.put(ShareDetailController());
  var infoFormController = Get.put(MysharedInfoController());
  MySharedInfoForm({
    super.key,
  });

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
                  "오픈 시간",
                  style: TextStyle(fontSize: 15, color: Config.blackColor),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: SharedTimePicker(title: "나눔 오픈 시간"),
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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: TextFormField(
              controller: infoFormController.userClothController,
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(
                hintText: "착장을 입력해주세요",
                enabledBorder: InputBorder.none,
                alignLabelWithHint: true,
              ),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          const Center(
            child: SharingButton(
              btnheight: 10,
              btnwidth: 80,
              btntext: "등록",
            ),
          )
        ],
      ),
    );
  }
}
