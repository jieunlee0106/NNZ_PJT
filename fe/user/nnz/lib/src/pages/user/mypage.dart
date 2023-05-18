import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
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
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter/services.dart';

class MyPage extends StatefulWidget {
  const MyPage({Key? key}) : super(key: key);

  @override
  _MyPageState createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  final controller = Get.put(MyPageController());
  final storage = const FlutterSecureStorage();
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

  void logoutAndNavigateToHome(BuildContext context) {
    // 로그아웃 로직 수행

    // 홈 화면으로 이동하여 재빌드
    Modular.to.navigate('/home');
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
                    yet: myInfo.statistics?.receive?.beforeCount ?? 0,
                    ing: myInfo.statistics?.receive?.ongoingCount ?? 0,
                    end: myInfo.statistics?.receive?.doneCount ?? 0,
                    page: const MySharedList(),
                  ),
                  GestureDetector(
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: const Text('로그아웃'),
                                content: const Text(
                                    '로그아웃 시 앱이 종료됩니다. \n로그아웃 하시겠습니까?'),
                                actions: <Widget>[
                                  TextButton(
                                      onPressed: () {
                                        Navigator.pop(context); // 모달 닫기
                                        storage.deleteAll();
                                        SystemChannels.platform.invokeMethod(
                                            'SystemNavigator.pop');
                                      },
                                      child: const Text('네')),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context); //close Dialog
                                    },
                                    child: const Text('아니요'),
                                  )
                                ],
                              );
                            });
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 20, horizontal: 30),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: Config.yellowColor,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              height: 30,
                              width: 80,
                              child: Align(
                                alignment: const Alignment(0.0, 0.0),
                                child: Text(
                                  '로그 아웃',
                                  style: TextStyle(
                                      color: Config.blackColor,
                                      fontSize: 13,
                                      fontWeight: FontWeight.w700),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ))
                ],
              ),
            ),
          ),
        ));
  }
}
