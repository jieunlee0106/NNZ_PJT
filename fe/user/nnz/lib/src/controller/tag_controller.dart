import 'package:get/get.dart';
import 'package:nnz/src/model/hash_tag_model.dart';
import 'package:nnz/src/model/nanum_tag.dart';
import 'package:nnz/src/model/popularity.dart';
import 'package:nnz/src/model/mypage_model.dart';
import 'package:nnz/src/model/nanum_type_list_model.dart';
import 'package:nnz/src/model/receive_type_list_model.dart';
import 'package:nnz/src/model/show_tag.dart';
import 'package:nnz/src/pages/user/mypage.dart';

import 'package:nnz/src/services/category_service.dart';
import 'package:nnz/src/services/home_service.dart';
import 'package:nnz/src/services/likes_service.dart';
import 'package:nnz/src/services/my_page_service.dart';
import 'package:nnz/src/services/mypage_share_list_service.dart';
import 'package:nnz/src/services/tag_service.dart';

class TagController extends GetxController {
  late NanumTag nanumTag;
  late ShowTag showTag;

  // 태그 나눔 조회
  getNanumTag(String TagName) async {
    try {
      final response = await TagService().getNanumTagList(tagName: TagName);
      print('테그 나눔 목록 불러오기');
      nanumTag = NanumTag.fromJson(response.data);
    } catch (e) {
      print(e);
    }
  }

  // 태그 쇼 조회
  getShowTag(String TagName) async {
    try {
      final response = await TagService().getShowTagList(tagName: TagName);
      print('t태그 공연 목록 불러오기');
      showTag = ShowTag.fromJson(response.data);
      print('t태그 공연 목록 불러왔어');
    } catch (e) {
      print(e);
    }
  }
}
