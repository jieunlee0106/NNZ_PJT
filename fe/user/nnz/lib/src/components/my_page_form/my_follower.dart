import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nnz/src/controller/my_page_controller.dart';
import 'package:nnz/src/pages/user/profile_edit.dart';
import 'package:nnz/src/config/config.dart';

class MyFollower extends StatelessWidget {
  final int? follower;
  final int? following;

  const MyFollower(
      {super.key, required this.follower, required this.following});
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    Text(
                      follower.toString(),
                      style: TextStyle(
                          color: Config.blackColor,
                          fontSize: 22,
                          fontWeight: FontWeight.bold),
                    ),
                    const Text(
                      '팔로워',
                      style: TextStyle(
                          color: Color.fromARGB(255, 59, 59, 59),
                          fontSize: 16,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text(
                      following.toString(),
                      style: TextStyle(
                          color: Config.blackColor,
                          fontSize: 22,
                          fontWeight: FontWeight.bold),
                    ),
                    const Text(
                      '팔로잉',
                      style: TextStyle(
                          color: Color.fromARGB(255, 59, 59, 59),
                          fontSize: 16,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 18,
            ),
            GestureDetector(
                onTap: () {
                  Get.toNamed("/profileEdit",
                      arguments:
                          Get.find<MyPageController>().myInfo.profileImage);
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Config.yellowColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  height: 40,
                  width: 1200,
                  child: Align(
                    alignment: const Alignment(0.0, 0.0),
                    child: Text(
                      '프로필 수정',
                      style: TextStyle(
                          color: Config.blackColor,
                          fontSize: 18,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}



// ** //
//
// 팔로우 비동기 코드, 나중에 상태관리 적용하면서 수정
//
// ** //

// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';

// class MyFollower extends StatefulWidget {
//   @override
//   _MyFollowerState createState() => _MyFollowerState();
// }

// class _MyFollowerState extends State<MyFollower> {
//   int _followerCount = 0;
//   int _followingCount = 0;

//   @override
//   void initState() {
//     super.initState();
//     _getFollowersCount();
//     _getFollowingCount();
//   }

//   Future<void> _getFollowersCount() async {
//     var response = await http.get(Uri.parse('http://localhost:3000/followers'));
//     if (response.statusCode == 200) {
//       setState(() {
//         _followerCount = jsonDecode(response.body)['count'];
//       });
//     } else {
//       print('Failed to load followers count');
//     }
//   }

//   Future<void> _getFollowingCount() async {
//     var response = await http.get(Uri.parse('http://localhost:3000/following'));
//     if (response.statusCode == 200) {
//       setState(() {
//         _followingCount = jsonDecode(response.body)['count'];
//       });
//     } else {
//       print('Failed to load following count');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('마이페이지'),
//       ),
//       body: Column(
//         children: [
//           Text('팔로워 수: $_followerCount'),
//           Text('팔로잉 수: $_followingCount'),
//         ],
//       ),
//     );
//   }
// }
