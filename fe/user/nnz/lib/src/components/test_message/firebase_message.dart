import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/test_controller.dart';

class FirebaseMessage extends StatelessWidget {
  FirebaseMessage({super.key});
  final controller = Get.put(TestController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("푸시알림테스트"),
      ),
      body: ElevatedButton(
        onPressed: () {},
        child: const Text("알림테스트"),
      ),
    );
  }
}
