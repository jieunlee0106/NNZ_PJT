import 'package:flutter/material.dart';
import 'package:nnz/src/components/category/category_dropdown.dart';
import 'package:nnz/src/components/icon_data.dart';
import 'package:nnz/src/components/category/hot_style.dart';
import 'package:nnz/src/components/category/hot_share_list.dart';
import 'package:nnz/src/components/gray_line_form/gray_line.dart';
import 'package:nnz/src/components/category/show_list.dart';
import 'package:nnz/src/components/tag/tag_show.dart';
import 'package:nnz/src/components/tag/tag_nanum_list.dart';
import 'package:nnz/src/components/tag/tag_show_text.dart';

class TagPage extends StatefulWidget {
  const TagPage({Key? key}) : super(key: key);

  @override
  _TagPageState createState() => _TagPageState();
}

class _TagPageState extends State<TagPage> {
  String? dropdownValue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        title: Center(child: Image.asset(ImagePath.logo, width: 80)),
        actions: [Icon(Icons.more_vert)],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TagShowText(
              text: ' {태그 이름}포함된 공연 이에요',
            ),
            TagShow(tagName: '태그'),
            GrayLine(),
            Text(
              '   #{태그 이름} 포함된 나눔 이에요',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            TagNanumList(
              items: [],
            ),
          ],
        ),
      ),
    );
  }
}
