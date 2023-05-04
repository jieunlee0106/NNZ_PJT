import 'package:flutter/material.dart';
import 'package:nnz/src/components/icon_data.dart';

import '../../components/other_user_from/other_sharing_detail.dart';
import '../../components/other_user_from/other_user_profile.dart';

class OtherProfileTwitter extends StatelessWidget {
  const OtherProfileTwitter({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: iconData(
            icon: ImagePath.logo,
            size: 240,
          ),
          centerTitle: true,
        ),
        body: const Column(
          children: [
            OtherUserProfile(),
            SizedBox(
              height: 16,
            ),
            OtherSharingDetail(),
          ],
        ));
  }
}
