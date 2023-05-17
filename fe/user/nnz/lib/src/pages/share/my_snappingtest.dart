import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:nnz/src/components/my_shared/my_shared_qrmake.dart';
import 'package:nnz/src/config/token.dart';
import 'package:nnz/src/model/other_share_info_model.dart';
import 'package:nnz/src/pages/share/my_shared_info_page.dart';
import 'package:snapping_sheet/snapping_sheet.dart';

class SheetBelowTest extends StatefulWidget {
  const SheetBelowTest({super.key, required this.nanumIds});
  final int nanumIds;

  @override
  State<SheetBelowTest> createState() => _SheetBelowTestState();
}

class _SheetBelowTestState extends State<SheetBelowTest> {
  Rx<Map<dynamic, dynamic>> result = Rx<Map<dynamic, dynamic>>({});

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
            "https://k8b207.p.ssafy.io/api/nanum-service/nanums/${widget.nanumIds}/info"),
        headers: {
          'Authorization': 'Bearer $token',
          "Accept-Charset": "utf-8",
        });
    OtherShareInfoModel infoModelClass =
        OtherShareInfoModel.fromJson(jsonDecode(res.body));
    result.value = jsonDecode(utf8.decode(res.bodyBytes));

    print("너야?");
    print(result.value);

    setState(() {
      result.value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SnappingSheet(
        lockOverflowDrag: true,
        grabbingHeight: 50,
        grabbing: const GrabbingWidget(),
        sheetBelow: SnappingSheetContent(
          draggable: true,
          child: Container(
            width: double.infinity,
            height: 200,
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            child: MyShareQr(
              receiveId: result.value["receiveId"],
            ),
          ),
        ),
        child: MySharedInfos(
          nanumIds: widget.nanumIds,
        ),
      ),
    );
  }
}

class GrabbingWidget extends StatelessWidget {
  const GrabbingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        boxShadow: [
          BoxShadow(blurRadius: 25, color: Colors.black.withOpacity(0.2)),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 20),
            width: 100,
            height: 7,
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(5),
            ),
          ),
          Container(
            color: Colors.grey[200],
            height: 2,
            margin: const EdgeInsets.all(15).copyWith(top: 0, bottom: 0),
          )
        ],
      ),
    );
  }
}
