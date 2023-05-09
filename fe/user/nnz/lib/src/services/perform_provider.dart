import 'package:get/get.dart';

class PerformProvider extends GetConnect {
  @override
  void onInit() async {}

  Future<Response> getPerformDetail() async {
    final res =
        await get("https://k8b207.p.ssafy.io/api/show-service/shows/818");
    return res;
  }
}
