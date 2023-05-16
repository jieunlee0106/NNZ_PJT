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
    int nanumId = 36;
    token = Get.find<BottomNavController>().accessToken;
    logger.i("토큰 값 : $token");
    final res = await post(
        "https://k8b207.p.ssafy.io/api/nanum-service/nanums/$nanumId/info",
        body,
        headers: {
          'Authorization':
              'Bearer eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiIxMiIsImlzcyI6Im5ueiIsImlhdCI6MTY4NDEzNjE0MywiYXV0aFByb3ZpZGVyIjoiTk5aIiwicm9sZSI6IlVTRVIiLCJpZCI6MTIsImVtYWlsIjoiamlqaUBnbWFpbC5jb20iLCJleHAiOjE2ODU0MzIxNDN9.Ce84oeRLQu87ucLYye039mNTsnH6Dn7XhrhLf9LAW1iVWRhhNkz3kiLFGV-QsqHgpxLfDIGVW-uuXZPe2mJHYg'
        });
    return res;
  }
}
