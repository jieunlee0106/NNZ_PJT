import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nnz/src/components/icon_data.dart';
import 'package:nnz/src/controller/propose_controller.dart';

import '../../components/propose_form/propose_btn.dart';
import '../../components/propose_form/show_title.dart';
import '../../components/propose_form/show_url.dart';

class ProposeShow extends StatelessWidget {
  ProposeShow({Key? key}) : super(key: key);
  final controller = Get.put(ProposeController());
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
          appBar: AppBar(
            title: iconData(
              icon: ImagePath.logo,
              size: 240,
            ),
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                ShowTitle(),
                const SizedBox(
                  height: 16,
                ),
                ShowUrl(),
                const SizedBox(
                  height: 16,
                ),
                const ProposeBtn(),
              ],
            ),
          )),
    );
  }
}
