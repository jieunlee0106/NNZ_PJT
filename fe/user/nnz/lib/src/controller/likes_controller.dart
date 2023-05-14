import 'package:get/get.dart';
import 'package:nnz/src/model/likes_model.dart';
import 'package:nnz/src/model/mypage_model.dart';
import 'package:nnz/src/model/nanum_type_list_model.dart';
import 'package:nnz/src/model/receive_type_list_model.dart';
import 'package:nnz/src/pages/user/mypage.dart';

import 'package:nnz/src/services/category_service.dart';
import 'package:nnz/src/services/likes_service.dart';
import 'package:nnz/src/services/my_page_service.dart';
import 'package:nnz/src/services/mypage_share_list_service.dart';

class LikesController extends GetxController {
  late List<Likes> likesList;

  getLikesList() async {
    try {
      final response = await LikesService().getLikesList();
      print(response);
      print(response.data.runtimeType);
      List<dynamic> items =
          response.data.map((item) => Map<String, dynamic>.from(item)).toList();
      likesList = items.map((item) => Likes.fromJson(item)).toList();
      // print(items);
      print('좋아요 나눔 목록 불러오기');
    } catch (e) {
      print(e);
    }
  }
}
