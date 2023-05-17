import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nnz/src/controller/other_user_profie_controller.dart';

import '../../config/config.dart';
import '../../model/other_profile_model.dart';

class OtherUserProfile extends StatefulWidget {
  const OtherUserProfile({Key? key}) : super(key: key);

  @override
  _OtherUserProfileState createState() => _OtherUserProfileState();
}

class _OtherUserProfileState extends State<OtherUserProfile> {
  final controller = Get.put(OtherUserProfileController());

  OtherUserProfileModel? _otherUserProfileModel;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final data = await controller.onOtherProfile();
    setState(() {
      _otherUserProfileModel = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(
        vertical: 18,
      ),
      child: _otherUserProfileModel == null
          ? const CircularProgressIndicator()
          : Column(
              children: [
                const SizedBox(
                  height: 16,
                ),
                CircleAvatar(
                  radius: 56,
                  backgroundImage: NetworkImage(
                    _otherUserProfileModel!.profileImage == null
                        ? "https://dummyimage.com/600x400/000/fff"
                        : _otherUserProfileModel!.profileImage!,
                  ),
                ),
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
                        "${_otherUserProfileModel!.nickname}",
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
                  onTap: () async {
                    await controller.onFollow(
                      userId: _otherUserProfileModel!.id!,
                    );
                    _loadData();
                  },
                  child:
                      controller.myConvertUserId == _otherUserProfileModel!.id
                          ? Container()
                          : Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 24,
                                vertical: 8,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6),
                                color: Config.yellowColor,
                              ),
                              child: _otherUserProfileModel!.isFollow == true
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
                              "${_otherUserProfileModel!.followerCount}",
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
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            "${_otherUserProfileModel!.followingCount}",
                            style: TextStyle(
                              fontSize: 18,
                              color: Config.blackColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            "팔로잉",
                            style: TextStyle(
                              fontSize: 14,
                              color: Config.blackColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
