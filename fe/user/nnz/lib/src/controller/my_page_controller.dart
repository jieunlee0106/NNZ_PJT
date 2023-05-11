import 'package:get/get.dart';
import 'package:nnz/src/model/mypage_model.dart';
import 'package:nnz/src/pages/user/mypage.dart';

import 'package:nnz/src/services/category_service.dart';
import 'package:nnz/src/services/my_page_service.dart';

class MyPageController extends GetxController {
  late MyPageModel myInfo;

  getMyInfo() async {
    try {
      final response = await MyPageService().getMyPageInfo();
      print('마이 페이지 API 통신 중 ~~~~~~~~~~~~~~');
      myInfo = MyPageModel.fromJson(response.data);
      print('값 할당');
    } catch (e) {
      print(e);
    }
  }
}
