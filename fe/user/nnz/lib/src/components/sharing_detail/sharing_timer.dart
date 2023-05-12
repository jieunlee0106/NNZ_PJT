import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:nnz/src/config/config.dart';
import "../../controller/shareingdetail_controller.dart";
import 'package:nnz/src/model/share_detail_model.dart';

class SharingDateTimer extends StatefulWidget {
  final VoidCallback onTimerFinished;

  const SharingDateTimer({Key? key, required this.onTimerFinished})
      : super(key: key);

  @override
  _SharingDateTimerState createState() => _SharingDateTimerState();
}

class _SharingDateTimerState extends State<SharingDateTimer> {
  final ShareDetailController sharedetailController =
      Get.put(ShareDetailController());
  Rx<Map<dynamic, dynamic>> result = Rx<Map<dynamic, dynamic>>({});
  bool isOpen = false;
  bool isCondition = false;
  final controller = Get.put(ShareDetailController());
  List<String> timeParts = [];
  int nanumId = 34;
  String durationTime = "";
  int day = 0;
  int hour = 0;
  int minute = 0;
  int second = 0;
  late Duration _remainingTime;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _remainingTime = Duration.zero;
    fetchData();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
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
    _remainingTime =
        Duration(days: day, hours: hour, minutes: minute, seconds: second);
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _remainingTime = _remainingTime - const Duration(seconds: 1);
        if (_remainingTime.inSeconds <= 0) {
          timer.cancel();
          widget.onTimerFinished();
        }
      });
    });
    setState(() {
      result.value;
      timeParts;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_remainingTime.inSeconds <= 0) {
      return Text(
        "나눔 받기",
        style: TextStyle(color: Config.blackColor, fontSize: 16),
      );
    }

    final days = _remainingTime.inDays;
    final hours = _remainingTime.inHours % 24;
    final minutes = _remainingTime.inMinutes % 60;
    final seconds = _remainingTime.inSeconds % 60;

    return Text('$days일 $hours시간 $minutes분 $seconds초',
        style: TextStyle(color: Config.blackColor, fontSize: 16));
  }
}
