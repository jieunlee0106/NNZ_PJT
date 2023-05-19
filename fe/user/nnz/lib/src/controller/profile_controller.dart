import 'dart:io';

import 'package:get/get.dart';

class ProfileController extends GetxController {
  var profileImage = Rx<File>(File('assets/images/home/pin.png'));

  void updateProfileImage(File image) {
    profileImage.value = image;
  }
}
