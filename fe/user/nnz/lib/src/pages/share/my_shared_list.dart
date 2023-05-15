import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nnz/src/components/my_page_form/share_list_info.dart';
import 'package:nnz/src/components/my_page_form/share_list_info2.dart';
import 'package:nnz/src/config/config.dart';
import 'package:nnz/src/components/icon_data.dart';
import 'package:nnz/src/controller/mypage_share_list_controller.dart';
import 'package:nnz/src/model/receive_type_list_model.dart';

class MySharedList extends StatefulWidget {
  const MySharedList({Key? key}) : super(key: key);

  @override
  _MySharedState createState() => _MySharedState();
}

class _MySharedState extends State<MySharedList> {
  final controller = Get.put(MyPageShareListController());

  late ReceiveTypeList receiveTypeList;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    loadMyInfo();
  }

  Future<void> loadMyInfo() async {
    await controller.getShareList('receive');
    print('sdfdsf');
    receiveTypeList = controller.receiveTypeList;

    print(receiveTypeList);
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
                      '나눔 참여 리스트',
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
                // ShareList2(
                //   items: receiveTypeList.content ?? [],
                // )
              ],
            ),
          ),
        ));
  }
}
