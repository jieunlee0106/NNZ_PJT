import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:nnz/src/components/my_shared/my_shared_map.dart';
import 'package:nnz/src/config/config.dart';
import 'package:nnz/src/config/token.dart';
import 'package:nnz/src/controller/bottom_nav_controller.dart';
import 'package:nnz/src/model/other_share_info_model.dart';

class MySharedInfos extends StatefulWidget {
  const MySharedInfos({super.key, required this.nanumIds});
  final int nanumIds;

  @override
  State<MySharedInfos> createState() => _MySharedInfosState();
}

class _MySharedInfosState extends State<MySharedInfos> {
  final token = Get.find<BottomNavController>().accessToken;
  Rx<Map<dynamic, dynamic>> result = Rx<Map<dynamic, dynamic>>({});
  double userLat = 0;
  double userLong = 0;
  bool _isLoading = true;
  final bool _isDataThere = true;
  @override
  void initState() {
    super.initState();
    fetchData();
  }

  void fetchData() async {
    String? token;
    token = await Token.getAccessToken();
    var res = await http.get(
        Uri.parse(
            "https://k8b207.p.ssafy.io/api/nanum-service/nanums/${widget.nanumIds}/info"),
        headers: {
          'Authorization': 'Bearer $token',
          "Accept-Charset": "utf-8",
        });
    OtherShareInfoModel infoModelClass =
        OtherShareInfoModel.fromJson(jsonDecode(res.body));
    result.value = jsonDecode(utf8.decode(res.bodyBytes));
    userLat = result.value["lat"];
    userLong = result.value["lng"];
    _isLoading = false;

    print(result.value);

    setState(() {
      result.value;
      userLat;
      userLong;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (result.value.isNotEmpty) {
      return Column(
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
          MyMapWidget(
            userLat: (double.parse(userLat.toString())),
            userLong: (double.parse(userLong.toString())),
            isUser: "현재 위치",
          ),
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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 45, vertical: 15),
            child: Text(
              "${result.value["nanumTime"].substring(0, 10)} ${result.value["nanumTime"].substring(11)}",
              style: const TextStyle(fontSize: 16),
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
          Padding(
            padding: const EdgeInsets.only(left: 45),
            child: Text(
              "${result.value["outfit"]}",
              style: const TextStyle(fontSize: 16),
            ),
          ),
          const SizedBox(
            height: 50,
          ),
        ],
      );
    } else {
      return const Center(
        child: Column(
          children: [
            SizedBox(
              height: 200,
            ),
            Text("아직 당일 착장이 등록되지 않았습니다"),
          ],
        ),
      );
    }
  }
}
