import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nnz/src/components/category/category_dropdown.dart';
import 'package:nnz/src/components/icon_data.dart';
import 'package:nnz/src/components/category/hot_style.dart';
import 'package:nnz/src/components/category/hot_share_list.dart';
import 'package:nnz/src/components/gray_line_form/gray_line.dart';
import 'package:nnz/src/components/category/show_list.dart';
import 'package:nnz/src/controller/category_controller.dart';

class MusicalPage extends StatefulWidget {
  const MusicalPage({Key? key}) : super(key: key);

  @override
  _MusicalPageState createState() => _MusicalPageState();
}

class _MusicalPageState extends State<MusicalPage> {
  String? dropdownValue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CategoryDropdown(
          items: <String>['콘서트', '뮤지컬', '연극', '페스티벌', '스포츠', 'e스포츠'],
          cartegory: '뮤지컬',
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            HotShareText(
                text: 'HOT한 뮤지컬',
                image: ImagePath.fire,
                smallText: '나눔 활동이 활발한 뮤지컬이에요'),
            HotShareList(),
            GrayLine(),
            ShowList(
              categoryName: '뮤지컬',
            ),
          ],
        ),
      ),
    );
  }
}
