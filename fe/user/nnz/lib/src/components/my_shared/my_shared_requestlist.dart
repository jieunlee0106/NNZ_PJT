import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:nnz/src/controller/bottom_nav_controller.dart';
import 'package:nnz/src/controller/list_scroll_controller.dart';
import 'package:nnz/src/model/nanum_type_list_model.dart';
import 'package:nnz/src/model/receive_type_list_model.dart';
import 'package:nnz/src/model/share_request_model.dart';

class MySharedList extends StatefulWidget {
  const MySharedList({super.key});

  @override
  State<MySharedList> createState() => _MySharedListState();
}

class _MySharedListState extends State<MySharedList> {
  final scrollControlloer = Get.put(InfiniteScrollController());
  final token = Get.find<BottomNavController>().accessToken;

  int nanumId = 21;
  List<Content> result = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  void fetchData() async {
    var res = await http.get(
        Uri.parse(
            "https://k8b207.p.ssafy.io/api/nanum-service/nanums/$nanumId/certification"),
        headers: {
          'Authorization':
              'Bearer eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiIyIiwiaXNzIjoibm56IiwiaWF0IjoxNjg0MDYzNDM3LCJhdXRoUHJvdmlkZXIiOiJOTloiLCJyb2xlIjoiQURNSU4iLCJpZCI6MiwiZW1haWwiOiJzc2FmeTAwMUBzc2FmeS5jb20iLCJleHAiOjE2ODUzNTk0Mzd9.XXv5ZRiwYhD1u5SEcr0tgnO9bqhcxHjgC3jxaMr9L4z1rGJwPm6AyrRuc0Dzo4zWie0SlWKflljBeHu7XblTLg',
          "Accept-Charset": "utf-8",
        });

    ShareRequestListModel shareRequestModelclass =
        ShareRequestListModel.fromJson(jsonDecode(utf8.decode(res.bodyBytes)));
    print(shareRequestModelclass);
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Obx(
        () => Padding(
          padding: const EdgeInsets.all(10.0),
          child: ListView.separated(
            controller: scrollControlloer.scrollController.value,
            itemBuilder: (_, index) {
              if (index < scrollControlloer.data.length) {
                var datum = scrollControlloer.data[index];
                return Material(
                  elevation: 3.0,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: ListTile(
                      leading: Container(
                        width: 40,
                        height: 40,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(
                                "assets/images/sharing_sample/profileimage.jpg"),
                            fit: BoxFit.cover,
                          ),
                          shape: BoxShape.circle,
                        ),
                      ),
                      title: Text('$datum번 인증자'),
                      trailing: Container(
                        width: 30,
                        height: 30,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(
                                "assets/images/sharing_sample/pass.png"),
                            fit: BoxFit.cover,
                          ),
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                  ),
                );
              }

              if (scrollControlloer.hasMore.value ||
                  scrollControlloer.isLoading.value) {
                return const Center(child: RefreshProgressIndicator());
              }

              return Container(
                padding: const EdgeInsets.all(10.0),
                child: Center(
                  child: Column(
                    children: [
                      const Text('데이터의 마지막 입니다'),
                      IconButton(
                        onPressed: () {
                          scrollControlloer.reload();
                        },
                        icon: const Icon(Icons.refresh_outlined),
                      ),
                    ],
                  ),
                ),
              );
            },
            separatorBuilder: (_, index) => const Divider(),
            itemCount: scrollControlloer.data.length + 1,
          ),
        ),
      ),
    );
  }
}
