import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:nnz/src/config/token.dart';
import 'package:nnz/src/model/share_info_model.dart';

class ShareInfoPage extends StatefulWidget {
  const ShareInfoPage({super.key});

  @override
  State<ShareInfoPage> createState() => _ShareInfoPageState();
}

class _ShareInfoPageState extends State<ShareInfoPage> {
  Rx<Map<dynamic, dynamic>> result = Rx<Map<dynamic, dynamic>>({});
  int nanumId = 37;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  void fetchData() async {
    String? token;
    token = await Token.getAccessToken();
    var res = await http.get(
        Uri.parse(
          "https://k8b207.p.ssafy.io/api/nanum-service/nanums/$nanumId/info",
        ),
        headers: {
          'Authorization': 'Bearer $token',
          "Accept-Charset": "utf-8",
        });

    ShareInfoModel shareInfoModelclass =
        ShareInfoModel.fromJson(jsonDecode(res.body));
    result.value = jsonDecode(utf8.decode(res.bodyBytes));
    print(result.value);

    setState(() {
      result.value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
