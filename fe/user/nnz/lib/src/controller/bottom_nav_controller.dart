import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

import '../components/message_popup.dart';

enum PageName { HOME, SERACH, UPLOAD, ACTIVITY, MYPAGE }

class BottomNavController extends GetxController {
  RxInt navIndex = 0.obs;
  RxInt curIndex = 0.obs;
  List<int> bottomHistory = [0];
  GlobalKey<NavigatorState> mypageKey = GlobalKey<NavigatorState>();
  final storage = const FlutterSecureStorage();
  String? accessToken;

  void changeBottomNav(int value, {bool hasGesture = true}) async {
    var page = PageName.values[value];
    print(page);
    switch (page) {
      case PageName.UPLOAD:
        curIndex(page.index);
        accessToken = await getToken();
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
      case PageName.SERACH:
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
    storage.deleteAll();
    // storage.write(key: "accessToken", value: "12131312313");
    // accessToken = await storage.read(key: "accessToken");
    print("들어와 $accessToken");
  }

  Future<String?> getToken() async {
    final accessToken = await storage.read(key: "accessToken");
    if (accessToken == null) {
      return null;
    }
    return accessToken;
  }

  Future<void> setToken({required String accessToken}) async {
    await storage.write(key: "accessToken", value: accessToken);
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
    //bottomHisttory가 하나 요소가 남았을 떄 시스템 종료 할 수 있게끔....
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
    //아직 요소들이 남아있다면 마지막 요소를 제거하고 체인지 index까지 해주면 된다.
    else {
      bottomHistory.removeLast();
      var index = bottomHistory.last;
      changeIndex(index, hasGesture: false);
      return false;
    }
  }
}
