import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:nnz/src/config/token.dart';
import 'package:nnz/src/pages/home/likes_page.dart';
import 'package:nnz/src/pages/user/mypage.dart';

import '../components/message_popup.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

enum PageName {
  HOME,
  SEARCH,
  UPLOAD,
  ACTIVITY,
  MYPAGE,
}

class BottomNavController extends GetxController {
  RxInt navIndex = 0.obs;
  RxInt curIndex = 0.obs;
  String? currentRoute;
  List<int> bottomHistory = [0];
  GlobalKey<NavigatorState> mypageKey = GlobalKey<NavigatorState>();
  final storage = const FlutterSecureStorage();
  String? accessToken;
  String? refreshToken;
  String? userId;
  FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
  late final token;
  void changeBottomNav(int value, {bool hasGesture = true}) async {
    var page = PageName.values[value];
    print(page);
    // switch (page) {
    //   case PageName.HOME:
    //     changeIndex(value);
    //     break;
    //   case PageName.SEARCH:
    //     changeIndex(value);
    //     break;
    //   case PageName.UPLOAD:
    //     curIndex(page.index);
    //     accessToken = await getToken();
    //     refreshToken = await Token.getRefreshToken();
    //     userId = await getUserId();

    //     print(accessToken);
    //     if (accessToken == null) {
    //       print("$accessToken $refreshToken");
    //       Get.toNamed("/register");
    //     } else {
    //       Get.toNamed("/sharingRegister");
    //     }
    //     break;

    //   case PageName.MYPAGE:
    //     curIndex(page.index);
    //     accessToken = await getToken();
    //     if (accessToken == null) {
    //       print(accessToken);
    //       Get.toNamed("/register");
    //     } else {
    //       Get.to(() => const MyPage());
    //     }
    //     break;
    //   case PageName.ACTIVITY:
    //     curIndex(page.index);
    //     accessToken = await getToken();

    //     if (accessToken == null) {
    //       print(accessToken);
    //       Get.toNamed("/register");
    //     } else {
    //       Get.to(() => const LikesPage());
    //     }
    //     break;
    // }
    switch (page) {
      case PageName.UPLOAD:
        curIndex(page.index);
        accessToken = await getToken();
        userId = await getUserId();
        if (accessToken == null) {
          print(accessToken);
          Get.offNamed("/register");
          // return;
        } else {
          Get.toNamed("/sharingRegister");
        }
        // Get.toNamed("/sharingRegister");
        break;
      case PageName.HOME:
      case PageName.SEARCH:
        changeIndex(value);
        break;
      case PageName.ACTIVITY:
        curIndex(page.index);
        accessToken = await getToken();
        if (accessToken == null) {
          print(accessToken);
          Get.offNamed("/register");
          return;
        }
        changeIndex(value);
        break;

      case PageName.MYPAGE:
        curIndex(page.index);
        accessToken = await getToken();
        if (accessToken == null) {
          print(accessToken);
          Get.offNamed("/register");
          return;
        }
        changeIndex(value);
        break;
    }
  }

  @override
  void onInit() async {
    super.onInit();
    _initNotification();
    token = await _getToken();
    // storage.deleteAll();

    // storage.write(key: "accessToken", value: "12131312313");
    // accessToken = await storage.read(key: "accessToken");
    print("들어와 $accessToken");
  }

  Future<String?> _getToken() async {
    try {
      final token = await firebaseMessaging.getToken();
      print("토큰 $token");
      return token;
    } catch (e) {}
    return null;
  }

  void _initNotification() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      // 앱이 foreground에서 실행 중일 때 푸시 알림 수신
      print('Got a message whilst in the foreground!');
      print('Message data: ${message.data}');

      if (message.notification != null) {
        print('Message also contained a notification: ${message.notification}');
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      // 앱이 background에서 실행 중이거나 종료된 상태에서 푸시 알림 수신 후 앱을 열 때
      print('A new onMessageOpenedApp event was published!');
      print('Message data: ${message.notification!.title}');

      if (message.notification != null) {
        print('Message also contained a notification: ${message.notification}');
      }
    });
  }

  Future<String?> getToken() async {
    final accessToken = await storage.read(key: "accessToken");
    if (accessToken == null) {
      return null;
    }
    return accessToken;
  }

  Future<String?> getUserId() async {
    final userId = await storage.read(key: "userId");
    if (userId == null) {
      return null;
    }
    return userId;
  }

  Future<void> setToken({required String accessToken}) async {
    await storage.write(key: "accessToken", value: accessToken);
    return;
  }

  Future<void> setUserId({required int userId}) async {
    await storage.write(key: "userId", value: userId.toString());
    return;
  }

  void changeIndex(int value, {bool hasGesture = true}) {
    if (bottomHistory.last != value) {
      bottomHistory.add(value);
    }
    navIndex(value);

    print(bottomHistory);
  }

  Future<bool> willPopAction() async {
    //bottomHistory가 하나 요소가 남았을 때 시스템 종료 할 수 있게끔....
    if (bottomHistory.length == 1) {
      showDialog(
        context: Get.context!,
        builder: (context) => MessagePopup(
            title: "시스템 종료",
            message: "정말 종료하시겠습니까?",
            okCallBack: () {
              exit(0);
            },
            cancelCallback: () {
              Get.back();
            }),
      );
      return true;
    }
//아직 요소들이 남아있다면 마지막 요소를 제거하고 changeIndex까지 해준다.
    else {
      bottomHistory.removeLast();
      var index = bottomHistory.last;
      changeIndex(index, hasGesture: false);
//Mypage 페이지를 떠날 때 네비게이터 스택을 제거한다.
      // if (index != PageName.MYPAGE.index) {
      //   mypageKey.currentState!.popUntil((route) => route.isFirst);
      // }
      return false;
    }
  }
}
