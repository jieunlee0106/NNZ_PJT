import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:nnz/src/components/sharing_detail/perform_share_card.dart';
import 'package:nnz/src/controller/perform_controller.dart';
import 'package:nnz/src/model/perform_share_list_model.dart';

class TestInfinite extends StatefulWidget {
  const TestInfinite({super.key});

  @override
  State<TestInfinite> createState() => _TestInfiniteState();
}

class _TestInfiniteState extends State<TestInfinite> {
  final PerformController performController = Get.put(PerformController());
  ScrollController listscrollcontroller = ScrollController();
  List<Content> result = [];
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
          "https://k8b207.p.ssafy.io/api/nanum-service/nanums?showId=4953&page=$paraPage&size=$size"),
      headers: {
        "Accept-Charset": "utf-8",
      },
    );
    print(res.body);
    ShareListModel listModelClass =
        ShareListModel.fromJson(jsonDecode(utf8.decode(res.bodyBytes)));
    result = result + listModelClass.content;
    isFirst = listModelClass.isFirst as bool;
    int localPage = page + 1;

    setState(() {
      result;
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
      itemCount: result.length,
      itemBuilder: (context, index) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Column(
          children: [
            ShareCard(
              opentime: result[index].openTime,
              title: result[index].title,
            )
          ],
        ),
      ),
    );
  }
}
