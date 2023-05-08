import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';

class ProfileProvider extends GetConnect {
  @override
  void onInit() async {
    await dotenv.load();
    httpClient.baseUrl = dotenv.env['BASE_URL'];
    httpClient.timeout = const Duration(microseconds: 5000);
    super.onInit();
  }

  //타 유저 정보 프로필 조회 api
  Future<Response> getOtherProfileInfo({required String userId}) async {
    final resposne = await get("/users/$userId");
    return resposne;
  }
}
