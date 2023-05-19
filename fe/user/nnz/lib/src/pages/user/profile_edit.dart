import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

import 'package:nnz/src/components/icon_data.dart';
import 'package:nnz/src/components/profile_edit_form/cur_pwd.dart';
import 'package:nnz/src/components/profile_edit_form/edit_btn.dart';
import 'package:nnz/src/components/profile_edit_form/new_pwd.dart';
import 'package:nnz/src/components/profile_edit_form/profile_edit.dart';

import 'package:nnz/src/controller/user_edit_controller.dart';

import '../../components/profile_edit_form/nickname_edit.dart';

class ProfileEdit extends StatefulWidget {
  const ProfileEdit({super.key});

  @override
  State<ProfileEdit> createState() => _ProfileEditState();
}

class _ProfileEditState extends State<ProfileEdit> {
  final controller = Get.put(UserEditController());

  final logger = Logger();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
        title: Center(child: Image.asset(ImagePath.logo, width: 80)),
        actions: const [
          Icon(Icons.more_vert),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const ProfileEditUser(),
            const SizedBox(
              height: 16,
            ),
            Container(
              color: Colors.white,
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
              ),
              child: Column(
                children: [
                  // 닉네임
                  NicknameEdit(),
                  // 새로운 비밀번호
                  const CurPwd(),

                  Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 10,
                    ),
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        NewPwd(),
                      ],
                    ),
                  ),

                  // 회원 수정 버튼
                  EditBtn(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
