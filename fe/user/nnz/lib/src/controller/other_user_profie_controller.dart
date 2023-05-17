import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:nnz/src/model/other_profile_model.dart';

import '../services/user_provider.dart';

class OtherUserProfileController extends GetxController {
  final logger = Logger();
  var otherUser = OtherUserProfileModel();
  late final userId;
  @override
  void onInit() {
    userId = int.parse(Get.parameters["userId"]!);
    logger.i(userId);
    onOtherProfile();
    super.onInit();
  }

  Future<OtherUserProfileModel> onOtherProfile() async {
    try {
      final response = await UserProvider().getOtherProfile(userId: userId);
      if (response.statusCode == 200) {
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

  Future<void> onFollow({required int userId}) async {
    logger.i(userId);
    try {
      final response = await UserProvider().followService(userId: userId);
      if (response.statusCode == 204) {
        logger.i("된거니?");
        onOtherProfile();
      } else {
        logger.i("${response.statusCode} : ${response.statusText}");
      }
    } catch (e) {
      final errorMessage = "$e";
      logger.e(errorMessage);
      throw Exception(errorMessage);
    }
  }
}
