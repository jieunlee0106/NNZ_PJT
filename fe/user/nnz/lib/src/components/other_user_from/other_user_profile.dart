import 'package:flutter/material.dart';
import 'package:nnz/src/components/icon_data.dart';

import '../../config/config.dart';

class OtherUserProfile extends StatelessWidget {
  const OtherUserProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(
        vertical: 18,
      ),
      child: Column(
        children: [
          const SizedBox(
            height: 16,
          ),
          const CircleAvatar(
            radius: 56,
            backgroundImage: NetworkImage(
                "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSE9G6p6azVeCiRw9gp13cxNFdxljVmDS90jg&usqp=CAU"),
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
                  "전종서",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Config.blackColor,
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              iconData(
                icon: ImagePath.twitterProfile,
                size: 80,
              ),
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 24,
              vertical: 8,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              color: Config.yellowColor,
            ),
            child: const Text(
              "팔로우",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
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
                        "1227",
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
                      "133",
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
      ),
    );
  }
}
