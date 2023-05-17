import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:nnz/src/controller/bottom_nav_controller.dart';
import 'package:nnz/src/model/share_info_model.dart';
import 'package:nnz/src/pages/share/my_shared_detail.dart';

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
      {required ShareInfoModel shareInfoModel, required int nanumIds}) async {
    final body = shareInfoModel.toJson();
    token = Get.find<BottomNavController>().accessToken;
    logger.i("토큰 값 : $token");
    final res = await post(
        "https://k8b207.p.ssafy.io/api/nanum-service/nanums/$nanumIds/info",
        body,
        headers: {
          'Authorization':
              'Bearer eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiIyIiwiaXNzIjoibm56IiwiaWF0IjoxNjg0MjE5NjM1LCJhdXRoUHJvdmlkZXIiOiJOTloiLCJyb2xlIjoiQURNSU4iLCJpZCI6MiwiZW1haWwiOiJzc2FmeTAwMUBzc2FmeS5jb20iLCJleHAiOjE2ODU1MTU2MzV9.5g02Ld3JjCLhLlrAQAgSi8u9idMX0FiT_wRDsvAqz3b2I31udCuAWbTw8DAaFz2Gpw5sT6o3Q3065GeSIE5_Jw'
        });
    if (res.statusCode == 201) {
      Get.to(() => const MyShareDetail());
    } else {
      Get.snackbar("실패", "정보 등록이 실패되었습니다");
    }
    return res;
  }
}
