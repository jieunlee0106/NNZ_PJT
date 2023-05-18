import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:nnz/src/components/sharing_detail/divide_line.dart';
import 'package:nnz/src/components/sharing_detail/share_float_button.dart';
import 'package:nnz/src/components/sharing_detail/sharing_card.dart';
import 'package:nnz/src/components/sharing_detail/sharing_tag.dart';
import 'package:nnz/src/config/config.dart';
import 'package:nnz/src/config/token.dart';
import 'package:nnz/src/model/share_detail_model.dart';

class ShareDatail extends StatefulWidget {
  const ShareDatail({super.key, required this.nanumIds});
  final int nanumIds;

  @override
  State<ShareDatail> createState() => _ShareDatailState();
}

class _ShareDatailState extends State<ShareDatail> {
  Rx<Map<dynamic, dynamic>> result = Rx<Map<dynamic, dynamic>>({});
  Rx<Map<dynamic, dynamic>> showData = Rx<Map<dynamic, dynamic>>({});
  Rx<Map<dynamic, dynamic>> nunumwriter = Rx<Map<dynamic, dynamic>>({});
  List<dynamic> thumbnailData = [];
  List<String> timeParts = [];
  bool bookmark = false;
  bool isCondition = false;
  bool timerFinish = false;
  bool isFollow = false;
  bool isBooking = false;
  int writerId = 0;
  String durationTime = "";
  int day = 0;
  int hour = 0;
  int minute = 0;
  int second = 0;
  String? token;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  void fetchData() async {
    token = await Token.getAccessToken();
    var res = await http.get(
        Uri.parse(
            "https://k8b207.p.ssafy.io/api/nanum-service/nanums/${widget.nanumIds}"),
        headers: {
          'Authorization': 'Bearer $token',
          "Accept-Charset": "utf-8",
        });

    ShareDetailModel shareDetailModelclass =
        ShareDetailModel.fromJson(jsonDecode(res.body));
    result.value = jsonDecode(utf8.decode(res.bodyBytes));
    print("에러코드 찍기");
    print(res.statusCode);
    showData.value = result.value["show"];
    thumbnailData = result.value["thumbnails"];
    bookmark = result.value["bookmark"];
    nunumwriter.value = result.value["writer"];
    writerId = nunumwriter.value["id"];
    durationTime = result.value["leftTime"];
    isBooking = result.value["booking"];
    timeParts = durationTime.split(", ");
    day = int.parse(timeParts[0].split(" : ")[1]);
    hour = int.parse(timeParts[1].split(" : ")[1]);
    minute = int.parse(timeParts[2].split(" : ")[1]);
    second = int.parse(timeParts[3].split(" : ")[1]);

    if (result.value["condition"].isEmpty) {
      isCondition = false;
    } else {
      isCondition = true;
    }

    _isLoading = false;

    setState(() {
      result.value;
      showData.value;
      nunumwriter.value;
      thumbnailData;
      bookmark;
      durationTime;
      _isLoading = false;
    });
  }

  void postBookmark() async {
    token = await Token.getAccessToken();
    var res = await http.post(
        Uri.parse(
            "https://k8b207.p.ssafy.io/api/user-service/users/bookmarks/${widget.nanumIds}"),
        headers: {'Authorization': 'Bearer $token'},
        body: {});
    if (res.statusCode == 200) {
      print("북마크 성공");
    } else if (res.statusCode == 401) {
      await Token.refreshAccessToken();
      final newToken = await Token.getAccessToken();

      var newRes = await http.post(
          Uri.parse(
              "https://k8b207.p.ssafy.io/api/user-service/users/bookmarks/${widget.nanumIds}"),
          headers: {'Authorization': 'Bearer $newToken'},
          body: {});
    } else {
      print("북마크 실패");
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          iconTheme: const IconThemeData(color: Colors.black),
          leading: const Icon(Icons.account_circle),
          actions: const [Icon(Icons.notifications)],
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 5,
            ),
            child: Column(
              children: [
                Center(
                  child: Image.network(
                    (thumbnailData != null
                        ? "${thumbnailData[0]}"
                        : "https://dummyimage.com/600x400/000/fff"),
                    height: 230,
                    width: double.maxFinite,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        "${result.value["title"]}",
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w500),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                const DevideLine(
                  bgColor: Color(0xFFF3C906),
                  pad: 10,
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: SharingDetailCard(
                    performTitle: "${showData.value["title"]}",
                    openDate: "${result.value["nanumDate"]}",
                    condition: ({result.value["condition"]}.isEmpty
                        ? "없음"
                        : "${result.value["condition"]}"),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: GestureDetector(
                        onTap: () {
                          Get.toNamed(
                              "/otherUserProfile/${nunumwriter.value["id"]}");
                        },
                        child: Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage((nunumwriter
                                          .value["profileImage"] !=
                                      null
                                  ? "${nunumwriter.value["profileImage"]}"
                                  : "https://dummyimage.com/600x400/000/fff")),
                              fit: BoxFit.cover,
                            ),
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                    ),
                    Text("${nunumwriter.value["nickname"]}"),
                    const SizedBox(
                      width: 15,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: SizedBox(
                    width: double.maxFinite,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "상세 정보",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text("${result.value["content"]}"),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: HashTagBadge(
                    tags: [],
                  ),
                ),
              ],
            ),
          ),
        ),
        bottomSheet: Container(
          decoration: const BoxDecoration(
            border: Border(
              top: BorderSide(width: 0.3, color: Colors.black),
              left: BorderSide(width: 0.3, color: Colors.black),
              right: BorderSide(width: 0.3, color: Colors.black),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                    onPressed: () {
                      setState(() {
                        bookmark = !bookmark;
                        postBookmark();
                      });
                    },
                    icon: bookmark
                        ? Icon(
                            Icons.favorite,
                            color: Config.yellowColor,
                            size: 32,
                          )
                        : const Icon(
                            Icons.favorite_border,
                            size: 32,
                          )),
                const SizedBox(
                  width: 20,
                ),
                // Visibility(
                //   visible: isBooking,
                //   child: GestureDetector(
                //       onTap: () => Get.to(() => SheetBelowTest(
                //             nanumIds: widget.nanumIds,
                //           )),
                //       child: const Text("나눔 확인하기")),
                // ),
                Visibility(
                  visible: !isBooking,
                  child: PurchaseButton(
                    condition: isCondition,
                    isOpen: timerFinish,
                    leftday: day,
                    lefthour: hour,
                    leftmin: minute,
                    leftsec: second,
                    nanumIds: widget.nanumIds,
                  ),
                ),
                Visibility(
                  visible: isBooking,
                  child: Container(
                      decoration: BoxDecoration(color: Config.greyColor),
                      child: const Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 80, vertical: 8),
                        child: Text("이미 받은 나눔입니다"),
                      )),
                ),
              ],
            ),
          ),
        ),
      );
    }
  }
}
