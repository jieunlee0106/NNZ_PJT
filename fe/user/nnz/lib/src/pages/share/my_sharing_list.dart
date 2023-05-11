import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:nnz/src/components/my_page_form/share_list_info.dart';
import 'package:nnz/src/components/nullPage.dart';
import 'package:nnz/src/config/config.dart';
import 'package:nnz/src/components/icon_data.dart';
import 'package:nnz/src/controller/mypage_share_list_controller.dart';
import 'package:nnz/src/model/nanum_type_list_model.dart';

class MySharingList extends StatefulWidget {
  const MySharingList({Key? key}) : super(key: key);

  @override
  _MySharingState createState() => _MySharingState();
}

class _MySharingState extends State<MySharingList> {
  final controller = Get.put(MyPageShareListController());

  late NanumTypeList nanumTypeList;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    loadMyInfo();
  }

  Future<void> loadMyInfo() async {
    await controller.getShareList('give');
    nanumTypeList = controller.nanumTypeList;
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading == true) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          iconTheme: const IconThemeData(color: Colors.black),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: Center(child: Image.asset(ImagePath.logo, width: 80)),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      '나의 나눔 리스트',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  height: 5,
                  decoration: BoxDecoration(
                    color: Config.yellowColor,
                  ),
                ),
                ShareList(
                  items: nanumTypeList.content ?? [],
                )
              ],
            ),
          ),
        ));
  }
}
