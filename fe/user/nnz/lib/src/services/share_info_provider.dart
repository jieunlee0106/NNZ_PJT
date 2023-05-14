import 'package:get/get.dart';

class ShareInfoProvider extends GetConnect {
  @override
  void onInit() async {}

  Future<Response> getShareInfo() async {
    int nanumId = 37;
    final res = await get(
        "https://k8b207.p.ssafy.io/api/nanum-service/nanums/$nanumId/info",
        headers: {
          'Authorization':
              'Bearer eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiIyIiwiaXNzIjoibm56IiwiaWF0IjoxNjgzODc5OTE1LCJhdXRoUHJvdmlkZXIiOiJOTloiLCJyb2xlIjoiQURNSU4iLCJpZCI6MiwiZW1haWwiOiJzc2FmeTAwMUBzc2FmeS5jb20iLCJleHAiOjE2ODUxNzU5MTV9.2LYhwfVY3IqYppIDG1M5RVYxCM_0mShx4h0CApbpS7J02Fw2d6SQQl4ZJgbpJfKX9RicTjQ_8rcJ9V3zWyBmcA'
        });
    return res;
  }
}
