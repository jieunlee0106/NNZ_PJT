import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:nnz/src/components/sharing_detail/perform_detail.dart';
import 'package:nnz/src/config/config.dart';
import 'package:nnz/src/controller/bottom_nav_controller.dart';
import 'package:nnz/src/controller/shareingdetail_controller.dart';
import 'package:nnz/src/model/share_detail_model.dart';

class MySharedCard extends StatefulWidget {
  const MySharedCard({super.key, required this.nanumIds});
  final int nanumIds;

  @override
  State<MySharedCard> createState() => _MySharedCardState();
}

class _MySharedCardState extends State<MySharedCard> {
  final token = Get.find<BottomNavController>().accessToken;
  final ShareDetailController sharedetailController =
      Get.put(ShareDetailController());

  Rx<Map<dynamic, dynamic>> result = Rx<Map<dynamic, dynamic>>({});
  Rx<Map<dynamic, dynamic>> showData = Rx<Map<dynamic, dynamic>>({});

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  void fetchData() async {
    var res = await http.get(
        Uri.parse(
            "https://k8b207.p.ssafy.io/api/nanum-service/nanums/${widget.nanumIds}"),
        headers: {
          'Authorization':
              'Bearer eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiIyIiwiaXNzIjoibm56IiwiaWF0IjoxNjg0MDY5NjYzLCJhdXRoUHJvdmlkZXIiOiJOTloiLCJyb2xlIjoiQURNSU4iLCJpZCI6MiwiZW1haWwiOiJzc2FmeTAwMUBzc2FmeS5jb20iLCJleHAiOjE2ODUzNjU2NjN9.tPkq_vcxjmyYlXg8ovvCD4JTBtkIA975OtBQcKmqZZrTHExCEvTsYL9V8iJ6dL64FDyHPde4C1U-cWh-l69ksA',
          "Accept-Charset": "utf-8",
        });

    ShareDetailModel shareDetailModelclass =
        ShareDetailModel.fromJson(jsonDecode(res.body));
    result.value = jsonDecode(utf8.decode(res.bodyBytes));
    showData.value = result.value["show"];
    print(result.value);

    setState(() {
      result.value;
      showData.value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              "${result.value["title"]}",
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
        Row(
          children: [
            PerformDetail(
              performTitle: "${showData.value["title"]}",
              iconName: Icons.room,
              textSize: 12,
            ),
            const SizedBox(
              width: 12,
            ),
            PerformDetail(
                performTitle: "${result.value["nanumDate"]}",
                iconName: Icons.calendar_month,
                textSize: 12),
          ],
        ),
      ],
    );
  }
}
