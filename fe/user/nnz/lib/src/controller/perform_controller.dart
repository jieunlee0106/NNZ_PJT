import 'dart:convert';

import 'package:get/get.dart';
import 'package:nnz/src/model/perform_detail_model.dart';

import 'package:nnz/src/services/perform_provider.dart';

class PerformController extends GetxController {
  static PerformController get to => Get.find();
  final PerformProvider _performProvider = Get.put(PerformProvider());

  final Rx<Map<String, dynamic>> performData = Rx<Map<String, dynamic>>({});

  @override
  void onReady() {
    super.onReady();
    getPerformData(); // 페이지가 준비되면 데이터를 가져옴
  }

  Future<void> getPerformData() async {
    final res = await _performProvider.getPerformDetail();
    if (res.statusCode == 200) {
      PerformDetailModel performDatailModelclass =
          PerformDetailModel.fromJson(jsonDecode(res.body));

      performData.value = res.body;
      print('title: ${performData.value['title']}');
      print('body: ${performData.value['body']}');
    } else {
      print("에러났따");
      print(res.body);
    }
  }
}
