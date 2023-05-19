import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';
import 'package:nnz/src/config/config.dart';
import 'package:nnz/src/controller/user_edit_controller.dart';
import 'package:permission_handler/permission_handler.dart';

class ProfileEditUser extends StatefulWidget {
  const ProfileEditUser({super.key});

  @override
  State<ProfileEditUser> createState() => _ProfileEditUserState();
}

class _ProfileEditUserState extends State<ProfileEditUser> {
  final controller = Get.put(UserEditController());
  bool _permissionGranted = false;
  @override
  void initState() {
    super.initState();
    logger.i(Get.arguments);
  }

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

  File _imageFile = File("${Get.arguments}");
  bool isPicked = false;
  final picker = ImagePicker();
  Future<void> _getImageFromCamera() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);
    setState(() {
      isPicked = true;
      _imageFile =
          pickedFile != null ? File(pickedFile.path) : File("${Get.arguments}");
    });
    controller.imageFile = _imageFile;
    setState(() {});
    logger.i("123 ${controller.imageFile}");
    Navigator.pop(context);
  }

  Future<void> _getImageFromGallery() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      isPicked = true;
      _imageFile =
          pickedFile != null ? File(pickedFile.path) : File("${Get.arguments}");
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
    return Container(
      width: Get.width,
      padding: const EdgeInsets.symmetric(
        vertical: 20,
      ),
      color: Colors.white,
      child: Column(
        children: [
          isPicked == true
              ? CircleAvatar(
                  radius: 50,
                  backgroundImage: FileImage(_imageFile),
                )
              : CircleAvatar(
                  radius: 50,
                  backgroundImage: Get.arguments == null
                      ? null
                      : NetworkImage(Get.arguments),
                ),
          const SizedBox(
            height: 16,
          ),
          GestureDetector(
            onTap: () {
              _showPicker(context);
            },
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
          )
        ],
      ),
    );
  }
}
