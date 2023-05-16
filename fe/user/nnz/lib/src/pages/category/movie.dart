import 'package:flutter/material.dart';
import 'package:nnz/src/components/category/category_dropdown.dart';
import 'package:nnz/src/components/icon_data.dart';
import 'package:nnz/src/components/category/hot_style.dart';
import 'package:nnz/src/components/category/hot_share_list.dart';
import 'package:nnz/src/components/gray_line_form/gray_line.dart';
import 'package:nnz/src/components/category/show_list.dart';

class MoviePage extends StatefulWidget {
  const MoviePage({Key? key}) : super(key: key);

  @override
  _MoviePageState createState() => _MoviePageState();
}

class _MoviePageState extends State<MoviePage> {
  String? dropdownValue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CategoryDropdown(
          items: <String>['콘서트', '뮤지컬', '연극', '페스티벌', '스포츠', 'e스포츠'],
          cartegory: '페스티벌',
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            HotShareText(
                text: 'HOT한 페스티벌',
                image: ImagePath.fire,
                smallText: '나눔 활동이 활발한 페스티벌이에요',
                categoryName: '뮤직페스티벌'),
            HotShareList(categoryName: '뮤직페스티벌'),
            GrayLine(),
            ShowList(categoryName: '뮤직페스티벌'),
          ],
        ),
      ),
    );
  }
}
