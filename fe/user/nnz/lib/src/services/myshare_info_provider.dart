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
    int nanumId = 34;
    token = Get.find<BottomNavController>().accessToken;
    logger.i("토큰 값 : $token");
    final res = await post(
        "https://k8b207.p.ssafy.io/api/nanum-service/nanums/$nanumId/info",
        body,
        headers: {
          'Authorization':
              'Bearer eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiIyIiwiaXNzIjoibm56IiwiaWF0IjoxNjgzNzkzNjQ3LCJhdXRoUHJvdmlkZXIiOiJOTloiLCJyb2xlIjoiQURNSU4iLCJpZCI6MiwiZW1haWwiOiJzc2FmeTAwMUBzc2FmeS5jb20iLCJleHAiOjE2ODUwODk2NDd9.yg4EzRzO_noxK9gN80lTE1CqgxoIIwQgU3CYMRQJ35jsEfZ6kxFgBCOyKRjrmcC-HdlUtg0GS_YVm3uuqxqPgQ'
        });
    return res;
  }
}
