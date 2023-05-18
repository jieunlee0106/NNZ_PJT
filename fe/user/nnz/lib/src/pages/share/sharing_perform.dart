import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:nnz/src/components/sharing_detail/perform_detail.dart';
import 'package:nnz/src/components/sharing_detail/test_infinite.dart';
import 'package:nnz/src/controller/list_scroll_controller.dart';

import 'package:nnz/src/components/sharing_detail/sharing_tag.dart';
import 'package:nnz/src/config/config.dart';

class SharePerformDetail extends StatefulWidget {
  const SharePerformDetail({super.key, required this.showIds});
  final int showIds;

  @override
  State<SharePerformDetail> createState() => _SharePerformDetailState();
}

class _SharePerformDetailState extends State<SharePerformDetail> {
  final scrollControlloer = Get.put(InfiniteScrollController());
  Rx<Map<dynamic, dynamic>> result = Rx<Map<dynamic, dynamic>>({});
  List<dynamic> TagsList = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  void fetchData() async {
    var res = await http.get(
      Uri.parse(
          "https://k8b207.p.ssafy.io/api/show-service/shows/${widget.showIds}"),
      headers: {
        "Accept-Charset": "utf-8",
      },
    );
    _isLoading = false;
    result.value = jsonDecode(utf8.decode(res.bodyBytes));

    TagsList = result.value["showTags"];
    print(result.value);
    String posterUrl = result.value["poster"];
    // if (posterUrl != null) {
    //   var response = await http.head(Uri.parse(posterUrl));
    //   if (response.statusCode != 200) {
    //     // 대체 이미지 URL 설정
    //     posterUrl = "https://dummyimage.com/600x400/000/fff";
    //   }
    // } else {
    //   // 대체 이미지 URL 설정
    //   posterUrl = "https://dummyimage.com/600x400/000/fff";
    // }

    setState(() {
      result.value;
      result.value["poster"] = posterUrl;
      _isLoading = false;
    });
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
        body: Obx(
          () => Column(children: [
            Stack(
              children: [
                Container(
                  decoration: const BoxDecoration(color: Color(0xFFE7E6E6)),
                  width: double.infinity,
                  height: 175,
                ),
                Center(
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Text(
                            "${result.value['title']}",
                            style: TextStyle(
                                fontSize: 24, color: Config.blackColor),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        children: [
                          const SizedBox(
                            width: 20,
                          ),
                          Image.network(
                            (result.value["poster"] != null
                                ? "${result.value["poster"]}"
                                : "https://dummyimage.com/600x400/000/fff"),
                            height: 150,
                            width: 120,
                            fit: BoxFit.cover,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 30),
                            child: SizedBox(
                              width: 190,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  PerformDetail(
                                      performTitle:
                                          "${result.value['location']}",
                                      iconName: Icons.room,
                                      textSize: 16),
                                  PerformDetail(
                                      performTitle:
                                          "${result.value['startDate']}",
                                      iconName: Icons.calendar_month,
                                      textSize: 16),
                                  PerformDetail(
                                      performTitle:
                                          "${result.value['ageLimit']}",
                                      iconName: Icons.person,
                                      textSize: 16),
                                  Container(
                                    height: 30,
                                  ),
                                  Row(
                                    children: [
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      const Text("공연 예매하러 가기"),
                                      Container(
                                        width: 10,
                                      ),
                                      const Icon(Icons.arrow_forward)
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: HashTagBadge(
                tags: TagsList,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            SizedBox(
              height: 300,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: TestInfinite(
                  showIds: widget.showIds,
                ),
              ),
            ),
          ]),
        ),
      );
    }
  }
}
