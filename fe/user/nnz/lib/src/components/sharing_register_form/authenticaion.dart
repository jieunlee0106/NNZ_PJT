import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

import '../../controller/sharing_register_controller.dart';
import '../icon_data.dart';

enum Condition { INIT, YES, NO }

class Authentication extends StatefulWidget {
  const Authentication({super.key});

  @override
  State<Authentication> createState() => _AuthenticationState();
}

class _AuthenticationState extends State<Authentication> {
  final controller = Get.put(SharingRegisterController());
  final logger = Logger();
  Condition _condition = Condition.INIT;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 18,
      ),
      color: Colors.white,
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              iconData(
                icon: ImagePath.certification,
                size: 80,
              ),
              const SizedBox(
                width: 12,
              ),
              const Padding(
                padding: EdgeInsets.only(
                  bottom: 4,
                ),
                child: Text(
                  "인증유무",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 36,
              vertical: 8,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Radio(
                  value: Condition.YES,
                  groupValue: _condition,
                  onChanged: (value) {
                    setState(() {
                      _condition = Condition.YES;
                    });
                    controller.isAuthentication(true);
                    logger.i(controller.isAuthentication.value);
                  },
                ),
                const Text(
                  "예",
                ),
                Radio(
                  value: Condition.NO,
                  groupValue: _condition,
                  onChanged: (value) {
                    setState(() {
                      _condition = Condition.NO;
                    });
                    controller.isAuthentication(false);
                    logger.i(controller.isAuthentication.value);
                  },
                ),
                const Text("아니오")
              ],
            ),
          ),
        ],
      ),
    );
  }
}
