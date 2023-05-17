import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nnz/src/controller/other_user_profie_controller.dart';

import '../../config/config.dart';
import '../../model/other_profile_model.dart';

class OtherUserProfile extends StatelessWidget {
  OtherUserProfile({super.key});
  final controller = Get.put(OtherUserProfileController());
  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        padding: const EdgeInsets.symmetric(
          vertical: 18,
        ),
        child: FutureBuilder<OtherUserProfileModel>(
            future: controller.onOtherProfile(),
            builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Error : ${snapshot.error}');
              } else if (snapshot.hasData == null) {
                return Text("해당 유저 정보가 없습니다.");
              }else{

              return Column(
                children: [
                  const SizedBox(
                    height: 16,
                  ),
                  CircleAvatar(
                      radius: 56,
                      backgroundImage: controller.otherUser.profileImage == null
                          ? null
                          : NetworkImage(controller.otherUser.profileImage!)),
                  const SizedBox(
                    height: 8,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          bottom: 2,
                        ),
                        child: Text(
                          "${controller.otherUser.nickname}",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Config.blackColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  GestureDetector(
                    onTap: () {
                      controller.onFollow(userId: 13);
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        color: Config.yellowColor,
                      ),
                      child: controller.otherUser.isFollow == true
                          ? const Text(
                              "언팔로우",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            )
                          : const Text(
                              "팔로우",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 10,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: [
                            Center(
                              child: Text(
                                "${controller.otherUser.followerCount}",
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Config.blackColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            Text(
                              "팔로워",
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Config.blackColor,
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              "${controller.otherUser.followingCount}",
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Config.blackColor,
                                  fontWeight: FontWeight.w600),
                            ),
                            Text(
                              "팔로잉",
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Config.blackColor,
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              );
              }
            }));
  }
}
