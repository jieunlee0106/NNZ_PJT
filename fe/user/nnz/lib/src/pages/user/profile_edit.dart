import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';

import 'package:nnz/src/components/icon_data.dart';
import 'package:nnz/src/components/gray_line_form/gray_line.dart';
import 'package:nnz/src/components/register_form/share_popup.dart';

import 'package:nnz/src/config/config.dart';
import 'package:nnz/src/controller/user_edit_controller.dart';
import 'package:permission_handler/permission_handler.dart';

class ProfileEdit extends StatefulWidget {
  const ProfileEdit({super.key});

  @override
  State<ProfileEdit> createState() => _ProfileEditState();
}

class _ProfileEditState extends State<ProfileEdit> {
  final controller = Get.put(UserEditController());

  bool _permissionGranted = false;

  final logger = Logger();
  Future<void> _checkPermission() async {
    final status = await Permission.camera.status;

    if (status.isGranted) {
      setState(() {
        _permissionGranted = true;
      });
    } else {
      final result = await Permission.camera.request();

      if (result.isGranted) {
        setState(() {
          _permissionGranted = true;
        });
      }
    }
  }

  File? _imageFile;
  bool isPwd = false;
  bool isPwdConfirm = false;
  final picker = ImagePicker();
  Future<void> _getImageFromCamera() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);
    setState(() {
      _imageFile = pickedFile != null ? File(pickedFile.path) : null;
    });
    controller.imageFile = _imageFile;
    setState(() {});
    logger.i("123 ${controller.imageFile}");
    Navigator.pop(context);
  }

  Future<void> _getImageFromGallery() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      _imageFile = pickedFile != null ? File(pickedFile.path) : null;
    });
    controller.imageFile = _imageFile;
    setState(() {});
    logger.i("123 ${controller.imageFile}");
    Navigator.pop(context);
  }

  Future<void> _showPicker(BuildContext context) async {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Wrap(
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('갤러리'),
                onTap: () async {
                  await _getImageFromGallery();
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_camera),
                title: const Text('카메라'),
                onTap: () async {
                  await _checkPermission();
                  await _getImageFromCamera();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          iconTheme: const IconThemeData(color: Colors.black),
          title: Center(child: Image.asset(ImagePath.logo, width: 80)),
          actions: const [Icon(Icons.more_vert)],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 30),
            child: Column(
              children: [
                Column(
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundImage:
                          _imageFile == null ? null : FileImage(_imageFile!),
                    ),
                    GestureDetector(
                      onTap: () {
                        _showPicker(context);
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 35),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Config.yellowColor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          height: 40,
                          width: 200,
                          child: Align(
                            alignment: const Alignment(0.0, 0.0),
                            child: Text(
                              '프로필 사진 변경',
                              style: TextStyle(
                                  color: Config.blackColor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                GrayLine(),
                Column(
                  children: [
                    // 닉네임
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  '닉네임',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      color: Config.blackColor),
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width: 260,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.grey),
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.white,
                                    ),
                                    child: TextField(
                                      controller: controller.nickController,
                                      decoration: const InputDecoration(
                                        border: InputBorder.none,
                                        contentPadding: EdgeInsets.symmetric(
                                            horizontal: 16),
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      if (controller.nickController.text ==
                                          '') {
                                        showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return const sharePopup(
                                                  popupMessage: "닉네임을 입력해주세요");
                                            });
                                      } else {
                                        controller.nickValidate(
                                            type: "nickname",
                                            text:
                                                controller.nickController.text);
                                      }
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Config.yellowColor,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      height: 40,
                                      width: 90,
                                      child: Align(
                                        alignment: const Alignment(0.0, 0.0),
                                        child: Text(
                                          '중복 확인',
                                          style: TextStyle(
                                              color: Config.blackColor,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    // 새로운 비밀번호
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 15,
                        vertical: 10,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  '현재 비밀번호',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Config.blackColor,
                                  ),
                                ),
                              ),
                              TextField(
                                controller: controller.curPwdController,
                                decoration: InputDecoration(
                                  suffixIcon: const Icon(Icons.visibility),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 16),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 15,
                        vertical: 10,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  '새로운 비밀번호',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Config.blackColor,
                                  ),
                                ),
                              ),
                              TextFormField(
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                controller: controller.newPwdController,
                                validator: (value) {
                                  isPwd = controller.onPasswordValidate(
                                      text: value!);
                                  controller.pwdChecked.value =
                                      isPwd ? true : false;
                                  logger.i(controller.pwdChecked.value);
                                  return isPwd ? null : "숫자, 문자, 특수문자 포함 8자 이상";
                                },
                                decoration: InputDecoration(
                                  suffixIcon: const Icon(Icons.visibility),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 16),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    // 비밀 번호 변경 확인
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 15,
                        right: 15,
                        top: 12,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  '새로운 비밀번호 확인',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Config.blackColor,
                                  ),
                                ),
                              ),
                              TextFormField(
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                onChanged: (value) {},
                                validator: (value) {
                                  isPwdConfirm =
                                      controller.newPwdController.text ==
                                              controller
                                                  .newPwdConfirmController.text
                                          ? true
                                          : false;
                                  return isPwdConfirm
                                      ? null
                                      : "비밀번호가 일치 하지 않습니다.";
                                },
                                controller: controller.newPwdConfirmController,
                                decoration: InputDecoration(
                                  suffixIcon: const Icon(Icons.visibility),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 16),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    // 회원 수정 버튼
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 15,
                        vertical: 36,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          GestureDetector(
                            onTap: () {
                              controller.onUpdateUser();
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: Config.yellowColor,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              height: 40,
                              width: 90,
                              child: Align(
                                alignment: const Alignment(0.0, 0.0),
                                child: Text(
                                  '회원 수정',
                                  style: TextStyle(
                                      color: Config.blackColor,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 16,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: Config.yellowColor,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            height: 40,
                            width: 90,
                            child: Align(
                              alignment: const Alignment(0.0, 0.0),
                              child: Text(
                                '회원 탈퇴',
                                style: TextStyle(
                                    color: Config.blackColor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ));
  }
}
