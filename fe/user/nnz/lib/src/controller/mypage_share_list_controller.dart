import 'package:get/get.dart';
import 'package:nnz/src/model/mypage_model.dart';
import 'package:nnz/src/model/nanum_type_list_model.dart';
import 'package:nnz/src/model/receive_type_list_model.dart';
import 'package:nnz/src/pages/user/mypage.dart';

import 'package:nnz/src/services/category_service.dart';
import 'package:nnz/src/services/my_page_service.dart';
import 'package:nnz/src/services/mypage_share_list_service.dart';

class MyPageShareListController extends GetxController {
  late NanumTypeList nanumTypeList;
  late ReceiveTypeList receiveTypeList;

  getShareList(String type) async {
    try {
      final response = await MyPageShareListService().getShareList(type: type);
      if (type == 'nanums') {
        nanumTypeList = NanumTypeList.fromJson(response.data);
        print('한 나눔 목록 저장');
      } else {
        receiveTypeList = ReceiveTypeList.fromJson(response.data);
        print('받은 나눔 목록 저장');
      }
      print('값 할당');
    } catch (e) {
      print(e);
    }
  }
}
