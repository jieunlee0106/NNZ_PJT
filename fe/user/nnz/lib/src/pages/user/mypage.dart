import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nnz/src/components/gray_line_form/gray_line.dart';
import 'package:nnz/src/components/icon_data.dart';
import 'package:nnz/src/components/my_page_form/profile_info.dart.dart';
import 'package:nnz/src/components/my_page_form/my_follower.dart';
import 'package:nnz/src/components/my_page_form/sharing_info.dart';
import 'package:nnz/src/config/config.dart';
import 'package:nnz/src/model/mypage_model.dart';
import 'package:nnz/src/pages/share/my_shared_list.dart';
import 'package:nnz/src/pages/share/my_sharing_list.dart';
import 'package:nnz/src/controller/my_page_controller.dart';

class MyPage extends StatefulWidget {
  const MyPage({Key? key}) : super(key: key);

  @override
  _MyPageState createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  final controller = Get.put(MyPageController());

  late MyPageModel myInfo;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    loadMyInfo();
  }

  Future<void> loadMyInfo() async {
    await controller.getMyInfo();
    myInfo = controller.myInfo;
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    // var myInfo = controller.myInfo;
    if (_isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          iconTheme: const IconThemeData(color: Colors.black),
          title: Center(child: Image.asset(ImagePath.logo, width: 80)),
          actions: const [Icon(Icons.more_vert)],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 30),
            child: Expanded(
              child: Column(
                children: [
                  Row(
                    children: [
                      MyProfile(
                        nickname: myInfo.nickname,
                        profileImage: myInfo.profileImage,
                      ),
                      MyFollower(
                        follower: myInfo.followerCount,
                        following: myInfo.followingCount,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  GrayLine(),
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: Row(
                          children: [
                            Image.asset(
                              ImagePath.gift,
                              width: 30,
                            ),
                            Text(
                              '  나의 나눔',
                              style: TextStyle(
                                color: Config.blackColor,
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                              ),
                            )
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 15, top: 10),
                            child: Container(
                                width: 135,
                                height: 5,
                                color:
                                    const Color.fromARGB(255, 230, 230, 230)),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SharingInfo(
                    share: '나눔 한 내역',
                    total: myInfo.statistics?.nanum?.totalCount ?? 0,
                    yet: myInfo.statistics?.nanum?.beforeCount ?? 0,
                    ing: myInfo.statistics?.nanum?.ongoingCount ?? 0,
                    end: myInfo.statistics?.nanum?.doneCount ?? 0,
                    page: const MySharingList(),
                  ),
                  SharingInfo(
                    share: '나눔 받은 내역',
                    total: myInfo.statistics?.receive?.totalCount ?? 0,
                    yet: myInfo.statistics?.receive?.totalCount ?? 0,
                    ing: myInfo.statistics?.receive?.totalCount ?? 0,
                    end: myInfo.statistics?.receive?.totalCount ?? 0,
                    page: const MySharedList(),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
