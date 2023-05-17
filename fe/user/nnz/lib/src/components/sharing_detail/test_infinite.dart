import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:nnz/src/components/sharing_detail/perform_share_card.dart';
import 'package:nnz/src/config/token.dart';
import 'package:nnz/src/model/perform_share_list_model.dart';
import 'package:nnz/src/pages/share/share_detail.dart';

class TestInfinite extends StatefulWidget {
  const TestInfinite({super.key, required this.showIds});
  final int showIds;

  @override
  State<TestInfinite> createState() => _TestInfiniteState();
}

class _TestInfiniteState extends State<TestInfinite> {
  ScrollController listscrollcontroller = ScrollController();
  Rx<Map<dynamic, dynamic>> result = Rx<Map<dynamic, dynamic>>({});
  List<dynamic> shareList = [];
  bool isLoading = true;
  bool isFirst = true;
  int page = 0;
  int size = 20;

  @override
  void initState() {
    super.initState();
    fetchData(page);
    handleNext();
  }

  void fetchData(paraPage) async {
    var res = await http.get(
      Uri.parse(
          "https://k8b207.p.ssafy.io/api/nanum-service/nanums?showId=${widget.showIds}&page=$paraPage&size=$size"),
      headers: {
        "Accept-Charset": "utf-8",
      },
    );
    result.value = jsonDecode(utf8.decode(res.bodyBytes));
    shareList = shareList + result.value["content"];
    ShareListModel listModelClass =
        ShareListModel.fromJson(jsonDecode(utf8.decode(res.bodyBytes)));

    isFirst = listModelClass.isFirst as bool;
    int localPage = page + 1;
    print(shareList);
    setState(() {
      result.value;
      shareList;
      isLoading = false;
      page = localPage;
    });
  }

  void handleNext() {
    listscrollcontroller.addListener(() async {
      if (listscrollcontroller.position.maxScrollExtent ==
          listscrollcontroller.position.pixels) {
        fetchData(page);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1,
      ),
      controller: listscrollcontroller,
      itemCount: shareList.length,
      itemBuilder: (context, index) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Column(
          children: [
            Visibility(
              visible: shareList.isNotEmpty,
              child: GestureDetector(
                onTap: () async {
                  final token = await Token.getAccessToken();
                  Logger().i("토큰있어? $token");
                  if (token == null) {
                    Get.offNamed("/register");
                  } else {
                    Get.to(() => ShareDatail(nanumIds: shareList[index]["id"]));
                  }
                },
                child: ShareCard(
                  title: shareList[index]["title"],
                  opentime: shareList[index]["openTime"],
                  img: (shareList[index]["thumbnail"] == null
                      ? "https://dummyimage.com/600x400/000/fff"
                      : "${shareList[index]["thumbnail"]}"),
                ),
              ),
            ),
            Visibility(
              visible: shareList.isEmpty,
              child: const Text("데이터가 없습니다"),
            )
          ],
        ),
      ),
    );
  }
}
