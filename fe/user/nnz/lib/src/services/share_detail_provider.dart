import 'package:get/get.dart';

class ShareDetailProvider extends GetConnect {
  @override
  void onInit() async {}

  Future<Response> getShareDetail() async {
    int nanumId = 35;
    final res = await get(
        "https://k8b207.p.ssafy.io/api/nanum-service/nanums/35",
        headers: {
          'Authorization':
              'Bearer eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiIyIiwiaXNzIjoibm56IiwiaWF0IjoxNjgzNzk0OTY4LCJhdXRoUHJvdmlkZXIiOiJOTloiLCJyb2xlIjoiQURNSU4iLCJpZCI6MiwiZW1haWwiOiJzc2FmeTAwMUBzc2FmeS5jb20iLCJleHAiOjE2ODUwOTA5Njh9.s9tLxl5DcZ3PqYicv-qJ-zNixXvX5sHZ5wY-q_gRL5Ute-JWsxiO-oqj7qpQCR4Hl5mYeP-jOd3HR7CZBgnc2g'
        });
    return res;
  }
}
