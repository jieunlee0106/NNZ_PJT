import 'package:flutter/material.dart';
import 'package:nnz/src/components/category/category_dropdown.dart';
import 'package:nnz/src/components/category/eports_detail.dart';
import 'package:nnz/src/components/icon_data.dart';

class ESportsPage extends StatefulWidget {
  const ESportsPage({Key? key}) : super(key: key);

  @override
  _ESportsPageState createState() => _ESportsPageState();
}

class _ESportsPageState extends State<ESportsPage> {
  String? dropdownValue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CategoryDropdown(
          items: <String>['콘서트', '뮤지컬', '연극', '페스티벌', '스포츠', 'e스포츠'],
          cartegory: 'e스포츠',
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: EsportsBanner(),
      ),
    );
  }
}
