import 'package:get/get.dart';
import 'package:nnz/src/model/popularity.dart';
import 'package:nnz/src/model/mypage_model.dart';
import 'package:nnz/src/model/nanum_type_list_model.dart';
import 'package:nnz/src/model/receive_type_list_model.dart';
import 'package:nnz/src/pages/user/mypage.dart';

import 'package:nnz/src/services/category_service.dart';
import 'package:nnz/src/services/home_service.dart';
import 'package:nnz/src/services/likes_service.dart';
import 'package:nnz/src/services/my_page_service.dart';
import 'package:nnz/src/services/mypage_share_list_service.dart';

class HomeController extends GetxController {
  late List<PopularityList> popularity;

  getHomeList() async {
    try {
      final response = await HomeService().getHomeInfo();
      print(response.data.runtimeType);
      print(response.data);
      List<dynamic> items =
          response.data.map((item) => Map<String, dynamic>.from(item)).toList();
      popularity = items.map((item) => PopularityList.fromJson(item)).toList();
      print('홈 인기 나눔 목록 불러오기');
    } catch (e) {
      print(e);
    }
  }

  // getHomeLocationList() async {
  //   try {
  //     final response = await HomeService().getLocationInfo();
  //     print(response.data.runtimeType);
  //     print(response.data);
  //     List<dynamic> items =
  //         response.data.map((item) => Map<String, dynamic>.from(item)).toList();
  //     popularity = items.map((item) => PopularityList.fromJson(item)).toList();
  //     print('홈 인기 나눔 목록 불러오기');
  //   } catch (e) {
  //     print(e);
  //   }
  // }
}
