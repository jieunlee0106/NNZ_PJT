import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nnz/src/components/gray_line_form/gray_line.dart';
import 'package:nnz/src/components/icon_data.dart';
import 'package:nnz/src/components/my_page_form/profile_info.dart.dart';
import 'package:nnz/src/components/my_page_form/my_follower.dart';
import 'package:nnz/src/components/my_page_form/sharing_info.dart';
import 'package:nnz/src/config/config.dart';
import 'package:nnz/src/model/mypage_model.dart';
import 'package:nnz/src/pages/share/my_shared_list.dart';
import 'package:nnz/src/pages/share/my_sharing_list.dart';
import 'package:nnz/src/controller/my_page_controller.dart';
import 'package:nnz/src/components/icon_data.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 200),
          child: Column(
            children: [
              Image.asset('assets/images/loading.gif'),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
