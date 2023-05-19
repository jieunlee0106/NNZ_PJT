import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:nnz/src/components/icon_data.dart';
import 'package:nnz/src/controller/bottom_nav_controller.dart';

import '../../components/other_user_from/other_sharing_detail.dart';
import '../../components/other_user_from/other_user_profile.dart';

class OtherProfile extends StatelessWidget {
  const OtherProfile({super.key});

  @override
  Widget build(BuildContext context) {
    Logger().i(Get.find<BottomNavController>().userId.runtimeType);
    return Scaffold(
        appBar: AppBar(
          title: iconData(
            icon: ImagePath.logo,
            size: 240,
          ),
          centerTitle: true,
        ),
        body: Column(
          children: [
            OtherUserProfile(),
            const SizedBox(
              height: 16,
            ),
            OtherSharingDetail(),
          ],
        ));
  }
}
