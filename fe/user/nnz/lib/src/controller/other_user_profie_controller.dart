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

  Future<void> onOtherProfile() async {
    try {
      final response = await UserProvider().getOtherProfile(userId: userId);
      if (response.statusCode == 200) {
        otherUser = OtherUserProfileModel.fromJson(response.body);
        logger.i("담아왔어 $otherUser");
      }
    } catch (e) {
      final errorMessage = "$e";
      logger.e(errorMessage);
      throw Exception(errorMessage);
    }
  }
}
