import 'package:get/get.dart';
import 'package:nnz/src/model/likes_model.dart';
import 'package:nnz/src/model/mypage_model.dart';
import 'package:nnz/src/model/nanum_type_list_model.dart';
import 'package:nnz/src/model/receive_type_list_model.dart';
import 'package:nnz/src/pages/user/mypage.dart';
import 'package:dio/dio.dart';
import 'package:nnz/src/services/category_service.dart';
import 'package:nnz/src/services/likes_service.dart';
import 'package:nnz/src/services/my_page_service.dart';
import 'package:nnz/src/services/mypage_share_list_service.dart';
import 'package:nnz/src/controller/bottom_nav_controller.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class LikesController extends GetxController {
  late List<Likes> likesList;
  final dio = Dio();
  final token = Get.find<BottomNavController>().accessToken;
  final userId = Get.find<BottomNavController>().userId;

  @override
  void onInit() async {
    await dotenv.load();
    // dio.options.baseUrl = dotenv.env['BASE_URL'];
    dio.options.headers['Authorization'] = 'Bearer $token';
    // dio.options.connectTimeout = timeout;
    super.onInit();
  }

  getLikesList() async {
    try {
      final response = await LikesService().getLikesList();
      print(response.data);
      List<dynamic> items =
          response.data.map((item) => Map<String, dynamic>.from(item)).toList();
      likesList = items.map((item) => Likes.fromJson(item)).toList();
      // print(items);
      print('좋아요 나눔 목록 불러오기');
    } catch (e) {
      print(e);
    }
  }

  // 찜 취소
  deleteLikesList({required int nanumId}) async {
    try {
      await dio.post(
        'https://k8b207.p.ssafy.io/api/user-service/users/bookmarks/69',
        options: Options(
          headers: {
            "authorization": "Bearer $token",
          },
        ),
      );
      getLikesList();
      print('찜 취소');
      getLikesList();
    } catch (e) {
      print(e);
    }
  }
}
