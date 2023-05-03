import 'package:flutter/material.dart';
import 'package:nnz/src/components/gray_line_form/gray_line.dart';

import 'package:nnz/src/components/icon_data.dart';
import 'package:nnz/src/components/my_page_form/profile_info.dart.dart';
import 'package:nnz/src/components/my_page_form/my_follower.dart';
import 'package:nnz/src/components/my_page_form/sharing_info.dart';

import 'package:nnz/src/config/config.dart';
import 'package:nnz/src/pages/share/my_shared_list.dart';
import 'package:nnz/src/pages/share/my_sharing_list.dart';

class MyPage extends StatelessWidget {
  const MyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.black),
          title: Center(child: Image.asset(ImagePath.logo, width: 80)),
          actions: [Icon(Icons.more_vert)],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 30),
            child: Expanded(
              child: Column(
                children: [
                  Row(
                    children: [
                      MyProfile(),
                      MyFollower(),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  GrayLine(),
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: Row(
                          children: [
                            Image.asset(
                              ImagePath.gift,
                              width: 30,
                            ),
                            Text(
                              '  나의 나눔',
                              style: TextStyle(
                                color: Config.blackColor,
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                              ),
                            )
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 15, top: 10),
                            child: Container(
                                width: 135,
                                height: 5,
                                color: Color.fromARGB(255, 230, 230, 230)),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SharingInfo(
                    share: '나눔 한 내역',
                    total: '8',
                    yet: '2',
                    ing: '1',
                    end: '4',
                    page: MySharingList(),
                  ),
                  SharingInfo(
                    share: '나눔 받은 내역',
                    total: '11',
                    yet: '3',
                    ing: '2',
                    end: '6',
                    page: MySharedList(),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
