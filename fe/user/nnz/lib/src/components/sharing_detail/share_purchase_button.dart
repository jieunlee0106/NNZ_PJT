import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:multi_image_picker_view/multi_image_picker_view.dart';
import 'package:nnz/src/components/sharing_detail/sharing_timer.dart';
import 'package:nnz/src/config/config.dart';
import 'package:nnz/src/model/share_detail_model.dart';
import "../../controller/shareingdetail_controller.dart";
import 'package:nnz/src/pages/share/sharing_complete.dart';

class SharePurchaseBottom extends StatefulWidget {
  final bool condition;
  final int leftday;
  bool isOpen;
  final int lefthour;
  final int leftmin;
  final int leftsec;

  SharePurchaseBottom({
    super.key,
    required this.isOpen,
    required this.condition,
    required this.leftday,
    required this.lefthour,
    required this.leftmin,
    required this.leftsec,
  });

  @override
  State<SharePurchaseBottom> createState() => _SharePurchaseBottomState();
}

class _SharePurchaseBottomState extends State<SharePurchaseBottom> {
  final ShareDetailController sharedetailController =
      Get.put(ShareDetailController());
  Rx<Map<dynamic, dynamic>> result = Rx<Map<dynamic, dynamic>>({});
  bool isOpen = false;
  bool isCondition = false;
  final controller = Get.put(ShareDetailController());
  List<String> timeParts = [];
  int nanumId = 36;
  String durationTime = "";
  int day = 0;
  int hour = 0;
  int minute = 0;
  int second = 0;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  void fetchData() async {
    var res = await http.get(
        Uri.parse(
            "https://k8b207.p.ssafy.io/api/nanum-service/nanums/$nanumId"),
        headers: {
          'Authorization':
              'Bearer eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiIyIiwiaXNzIjoibm56IiwiaWF0IjoxNjgzODY0NjM1LCJhdXRoUHJvdmlkZXIiOiJOTloiLCJyb2xlIjoiQURNSU4iLCJpZCI6MiwiZW1haWwiOiJzc2FmeTAwMUBzc2FmeS5jb20iLCJleHAiOjE2ODUxNjA2MzV9.pd0j7IpJvhVwUFP-2RIxiinohoOk18ectzV1Qfu3eyhijyvEC1I66_793yQjX2aoyrkKgTTA3ERkZjKgmEIhtg',
          "Accept-Charset": "utf-8",
        });
    ShareDetailModel shareDetailModelclass =
        ShareDetailModel.fromJson(jsonDecode(res.body));
    result.value = jsonDecode(utf8.decode(res.bodyBytes));
    print(result.value);
    durationTime = result.value["leftTime"];
    timeParts = durationTime.split(", ");
    day = int.parse(timeParts[0].split(" : ")[1]);
    hour = int.parse(timeParts[1].split(" : ")[1]);
    minute = int.parse(timeParts[2].split(" : ")[1]);
    second = int.parse(timeParts[3].split(" : ")[1]);
    print(day);
    setState(() {
      result.value;
      timeParts;
    });
  }

  @override
  Widget build(BuildContext context) {
    final duration =
        Duration(days: day, hours: hour, minutes: minute, seconds: second);
    return SizedBox(
      width: 300,
      height: 40,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: Config.yellowColor),
        onPressed: () {
          print(duration);
          if (isOpen) {
            showModalBottomSheet(
              context: context,
              isDismissible: true,
              backgroundColor: Colors.transparent,
              builder: (BuildContext context) {
                return Container(
                  height: MediaQuery.of(context).size.height * 0.40,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Visibility(
                        visible: widget.condition,
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 10,
                            ),
                            const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: 30,
                                  height: 30,
                                  child: Image(
                                      image: AssetImage(
                                          "assets/images/sharing_sample/sharingstop.png")),
                                ),
                                Text(
                                  "잠깐!",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                            const Text(
                              "인증이 필요한 나눔입니다",
                              style: TextStyle(
                                  fontSize: 11, color: Color(0xFF838282)),
                            ),
                            SizedBox(
                              width: 370,
                              height: 150,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.white),
                                onPressed: () {},
                                child: Container(
                                  decoration:
                                      const BoxDecoration(color: Colors.white),
                                  child: MultiImagePickerView(
                                      controller:
                                          controller.authImageController,
                                      addButtonTitle: ""),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Visibility(
                          visible: !widget.condition,
                          child: const Text("나눔을 받으시겠습니까?")),
                      SizedBox(
                        width: 370,
                        height: 40,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Config.yellowColor),
                          onPressed: () {
                            Get.to(() => const SharingComplete());
                          },
                          child: Container(
                            decoration:
                                BoxDecoration(color: Config.yellowColor),
                            child: Text(
                              '나눔 받기',
                              style: TextStyle(
                                fontSize: 14.0,
                                color: Config.blackColor,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          }
        },
        child: Container(
            decoration: BoxDecoration(color: Config.yellowColor),
            child: SharingDateTimer(
              duration: Duration(
                  days: day, hours: hour, minutes: minute, seconds: second),
              onTimerFinished: () => {isOpen = true},
            )),
      ),
    );
  }
}
