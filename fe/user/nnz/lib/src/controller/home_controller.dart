import 'package:get/get.dart';
import 'package:nnz/src/model/hash_tag_model.dart';
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
  late List<HashTagModel> hashTag;

  // 인기 해시테그 불러오기
  getHashTag() async {
    try {
      final response = await HomeService().getHashTag();
      print(response.data.runtimeType);
      print(response.data);
      List<dynamic> items =
          response.data.map((item) => Map<String, dynamic>.from(item)).toList();
      hashTag = items.map((item) => HashTagModel.fromJson(item)).toList();
      print('인기 해시 테그 목록 불러오기');
    } catch (e) {
      print(e);
    }
  }

  // 인기 나눔 목록 불러오기
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

  // 주변 나눔 목록 불러오기
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
