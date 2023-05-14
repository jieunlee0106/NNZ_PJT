import 'package:get/get.dart';

class ShareDetailProvider extends GetConnect {
  @override
  void onInit() async {}

  Future<Response> getShareDetail() async {
    int nanumId = 11;
    final res = await get(
        "https://k8b207.p.ssafy.io/api/nanum-service/nanums/35",
        headers: {
          'Authorization':
              'Bearer eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiIyIiwiaXNzIjoibm56IiwiaWF0IjoxNjgzODc5OTE1LCJhdXRoUHJvdmlkZXIiOiJOTloiLCJyb2xlIjoiQURNSU4iLCJpZCI6MiwiZW1haWwiOiJzc2FmeTAwMUBzc2FmeS5jb20iLCJleHAiOjE2ODUxNzU5MTV9.2LYhwfVY3IqYppIDG1M5RVYxCM_0mShx4h0CApbpS7J02Fw2d6SQQl4ZJgbpJfKX9RicTjQ_8rcJ9V3zWyBmcA'
        });
    return res;
  }

  Future<Response> getMyShareRequest() async {
    int nanumId = 21;
    final res = await get(
        "https://k8b207.p.ssafy.io/api/nanum-service/nanums/$nanumId/certification",
        headers: {
          'Authorization':
              'Bearer eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiIyIiwiaXNzIjoibm56IiwiaWF0IjoxNjgzODc5OTE1LCJhdXRoUHJvdmlkZXIiOiJOTloiLCJyb2xlIjoiQURNSU4iLCJpZCI6MiwiZW1haWwiOiJzc2FmeTAwMUBzc2FmeS5jb20iLCJleHAiOjE2ODUxNzU5MTV9.2LYhwfVY3IqYppIDG1M5RVYxCM_0mShx4h0CApbpS7J02Fw2d6SQQl4ZJgbpJfKX9RicTjQ_8rcJ9V3zWyBmcA'
        });
    return res;
  }
}
