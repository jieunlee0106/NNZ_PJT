import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:nnz/src/model/other_profile_model.dart';

import '../services/user_provider.dart';

class OtherUserProfileController extends GetxController {
  final logger = Logger();
  UniqueKey refreshKey = UniqueKey();

  final storage = const FlutterSecureStorage();
  var otherUser = OtherUserProfileModel();
  late final userId;
  String? myUserId;
  int? myConvertUserId;
  @override
  void onInit() async {
    userId = int.parse(Get.parameters["userId"]!);
    logger.i(userId);
    myUserId = await storage.read(key: 'userId');
    logger.i("나의 아이디 $myUserId");
    myConvertUserId = int.parse(myUserId!);
    onOtherProfile();
    super.onInit();
  }

  Future<OtherUserProfileModel> onOtherProfile() async {
    try {
      final response = await UserProvider().getOtherProfile(userId: userId);
      if (response.statusCode == 200) {
        otherUser = OtherUserProfileModel();
        otherUser = OtherUserProfileModel.fromJson(response.body);
        logger.i("담아왔어 $otherUser");
        return otherUser;
      } else {
        final errorMessage = "(${response.statusCode}): ${response.body}";
        logger.e(errorMessage);
        throw Exception(errorMessage);
      }
    } catch (e) {
      final errorMessage = "$e";
      logger.e(errorMessage);
      throw Exception(errorMessage);
    }
  }

  Future<void> refreshProfile() async {
    await onOtherProfile();
    update();
  }

  Future<void> onFollow({required int userId}) async {
    logger.i(userId);
    try {
      final response = await UserProvider().followService(userId: userId);
      if (response.statusCode == 200) {
        logger.i("된거니?");
        refreshProfile();
      } else {
        logger.i(
            "${response.statusCode} : ${response.statusText} : ${response.body}");
      }
    } catch (e) {
      final errorMessage = "$e";
      logger.e(errorMessage);
      throw Exception(errorMessage);
    }
  }
}
