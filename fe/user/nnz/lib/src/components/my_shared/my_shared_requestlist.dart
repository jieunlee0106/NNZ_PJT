import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:nnz/src/controller/bottom_nav_controller.dart';
import 'package:nnz/src/controller/list_scroll_controller.dart';

class MySharedRequestList extends StatefulWidget {
  const MySharedRequestList({super.key});

  @override
  State<MySharedRequestList> createState() => _MySharedRequestList();
}

class _MySharedRequestList extends State<MySharedRequestList> {
  final scrollControlloer = Get.put(InfiniteScrollController());
  final token = Get.find<BottomNavController>().accessToken;

  List<dynamic> result = [];

  int nanumId = 71;
  int dataLength = 0;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  void fetchData() async {
    try {
      var res = await http.get(
          Uri.parse(
              "https://k8b207.p.ssafy.io/api/nanum-service/nanums/$nanumId/certification"),
          headers: {
            'Authorization':
                'Bearer eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiIyIiwiaXNzIjoibm56IiwiaWF0IjoxNjg0MDYzNDM3LCJhdXRoUHJvdmlkZXIiOiJOTloiLCJyb2xlIjoiQURNSU4iLCJpZCI6MiwiZW1haWwiOiJzc2FmeTAwMUBzc2FmeS5jb20iLCJleHAiOjE2ODUzNTk0Mzd9.XXv5ZRiwYhD1u5SEcr0tgnO9bqhcxHjgC3jxaMr9L4z1rGJwPm6AyrRuc0Dzo4zWie0SlWKflljBeHu7XblTLg',
            "Accept-Charset": "utf-8",
          });
      result = json.decode(res.body);
      dataLength = result.length;
      print(result);
      setState(() {
        result;
      });
    } catch (err) {
      print(err);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 400,
      child: ListView.builder(
          itemCount: dataLength,
          itemBuilder: ((context, index) {
            return Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: ListTile(
                  leading: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: NetworkImage(
                          (result[index]["image"] == null
                              ? "https://dummyimage.com/600x400/000/fff"
                              : "${result[index]["image"]}"),
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                    width: 40,
                    height: 40,
                  ),
                  title: Text("${result[index]["email"]}"),
                ));
          })),
    );
  }
}
