import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:nnz/src/controller/bottom_nav_controller.dart';
import 'package:nnz/src/model/share_info_model.dart';

class MyShareInfoProvider extends GetConnect {
  String? token;
  final logger = Logger();
  final storage = const FlutterSecureStorage();
  final headers = {
    'Content-Type': 'application/json',
  };

  @override
  void onInit() async {
    await dotenv.load();
    httpClient.baseUrl = dotenv.env['BASE_URL'];
    httpClient.timeout = const Duration(milliseconds: 5000);
    token = await storage.read(key: 'accessToken');
    super.onInit();
  }

  Future<Response> postShareInfo(
      {required ShareInfoModel shareInfoModel}) async {
    final body = shareInfoModel.toJson();
    int nanumId = 35;
    token = Get.find<BottomNavController>().accessToken;
    logger.i("토큰 값 : $token");
    final res = await post(
        "https://k8b207.p.ssafy.io/api/nanum-service/nanums/$nanumId/info",
        body,
        headers: {
          'Authorization':
              'Bearer eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiIyIiwiaXNzIjoibm56IiwiaWF0IjoxNjgzNzk0OTY4LCJhdXRoUHJvdmlkZXIiOiJOTloiLCJyb2xlIjoiQURNSU4iLCJpZCI6MiwiZW1haWwiOiJzc2FmeTAwMUBzc2FmeS5jb20iLCJleHAiOjE2ODUwOTA5Njh9.s9tLxl5DcZ3PqYicv-qJ-zNixXvX5sHZ5wY-q_gRL5Ute-JWsxiO-oqj7qpQCR4Hl5mYeP-jOd3HR7CZBgnc2g'
        });
    return res;
  }
}
