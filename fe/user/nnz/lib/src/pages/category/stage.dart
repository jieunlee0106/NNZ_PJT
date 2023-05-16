import 'package:flutter/material.dart';
import 'package:nnz/src/components/category/category_dropdown.dart';
import 'package:nnz/src/components/icon_data.dart';
import 'package:nnz/src/components/category/hot_style.dart';
import 'package:nnz/src/components/category/hot_share_list.dart';
import 'package:nnz/src/components/gray_line_form/gray_line.dart';
import 'package:nnz/src/components/category/show_list.dart';

class StagePage extends StatefulWidget {
  const StagePage({Key? key}) : super(key: key);

  @override
  _StagePageState createState() => _StagePageState();
}

class _StagePageState extends State<StagePage> {
  String? dropdownValue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CategoryDropdown(
          items: <String>['콘서트', '뮤지컬', '연극', '페스티벌', '스포츠', 'e스포츠'],
          cartegory: '연극',
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            HotShareText(
                text: 'HOT한 연극',
                image: ImagePath.fire,
                smallText: '나눔 활동이 활발한 연극이에요',
                categoryName: '연극'),
            HotShareList(categoryName: '연극'),
            GrayLine(),
            ShowList(categoryName: '연극'),
          ],
        ),
      ),
    );
  }
}
