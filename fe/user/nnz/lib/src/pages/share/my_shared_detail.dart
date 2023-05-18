import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:nnz/src/components/icon_data.dart';
import 'package:nnz/src/components/my_shared/my_shared_infocard.dart';
import 'package:nnz/src/components/my_shared/my_shared_requestlist.dart';
import 'package:nnz/src/components/sharing_detail/divide_line.dart';
import 'package:nnz/src/components/sharing_detail/sharing_button.dart';
import 'package:nnz/src/config/token.dart';
import 'package:nnz/src/controller/list_scroll_controller.dart';
import 'package:nnz/src/model/myshare_info_detail_model.dart';
import 'package:nnz/src/pages/share/my_shared_auth.dart';
import 'package:nnz/src/pages/share/my_shared_info.dart';
import 'package:nnz/src/pages/share/my_shared_info_form.dart';
import 'package:nnz/src/pages/share/my_shared_qrleader.dart';
import 'package:nnz/src/pages/user/mypage.dart';

final scrollControlloer = Get.put(InfiniteScrollController());

class MyShareDetail extends StatefulWidget {
  const MyShareDetail({super.key, required this.nanumIds});

  final int nanumIds;

  @override
  State<MyShareDetail> createState() => _MyShareDetailState();
}

class _MyShareDetailState extends State<MyShareDetail> {
  // int nanumIds = 104;

  final scrollControlloer = Get.put(InfiniteScrollController());

  Rx<Map<dynamic, dynamic>> result = Rx<Map<dynamic, dynamic>>({});
  String? token;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  void fetchData() async {
    token = await Token.getAccessToken();
    var res = await http.get(
        Uri.parse(
            "https://k8b207.p.ssafy.io/api/user-service/users/nanums/${widget.nanumIds}"),
        headers: {'Authorization': 'Bearer $token', "Accept-Charset": "utf-8"});
    MyShareInfoDetailModel myshareinfoModelcalss =
        MyShareInfoDetailModel.fromJson(jsonDecode(res.body));
    // print("상세정보줘");
    result.value = jsonDecode(utf8.decode(res.bodyBytes));
    // print(result.value);
  }
  void delete() async {

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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            MySharedCard(
              nanumIds: widget.nanumIds,
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
                Visibility(
                  visible: (result.value["data"] == null),
                  child: GestureDetector(
                    onTap: () => Get.to(() => MySharedInfoForm(
                          nanumIds: widget.nanumIds,
                        )),
                    child: const SharingButton(
                        btnheight: 10, btnwidth: 53, btntext: "당일 정보 입력"),
                  ),
                ),
                Visibility(
                  visible: (result.value["data"] != null),
                  child: GestureDetector(
                    onTap: () => Get.to(() => const MySharedInfo()),
                    child: const SharingButton(
                        btnheight: 10, btnwidth: 53, btntext: "당일 정보 확인"),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                GestureDetector(
                  onTap: () => Get.to(() => ShareQrLeader(
                        nanumIds: widget.nanumIds,
                      )),
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
                  onTap: () => Get.to(() => SharedAuthCheck(
                        nanumIds: widget.nanumIds,
                      )),
                  child: const Row(
                    children: [
                      Text("인증 확인"),
                      Icon(Icons.arrow_forward),
                    ],
                  ),
                ),
              ],
            ),
            MySharedRequestList(
              nanumIds: widget.nanumIds,
            ),
            const Text("삭제")
          ],
        ),
      ),
    );
  }
}
