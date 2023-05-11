import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:nnz/src/model/share_info_model.dart';

class MyShareInfoProvider extends GetConnect {
  final logger = Logger();
  final headers = {
    'Content-Type': 'application/json',
  };

  @override
  void onInit() async {
    await dotenv.load();
    httpClient.baseUrl = dotenv.env['BASE_URL'];
    httpClient.timeout = const Duration(milliseconds: 5000);
    super.onInit();
  }

  Future<Response> postShareInfo(
      {required ShareInfoModel shareInfoModel}) async {
    final body = shareInfoModel.toJson();
    int nanumId = 4410;
    final res = await post("/nanum-service/nanums/$nanumId/info", body);
    return res;
  }
}
