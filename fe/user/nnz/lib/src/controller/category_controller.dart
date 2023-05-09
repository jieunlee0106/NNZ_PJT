import 'package:get/get.dart';
import 'package:dio/dio.dart';

class CategoryController extends GetxController {
  var categoryList = [];

  void getCategoryList() async {
    try {
      final response = await Dio().get(
        'https://k8b207.p.ssafy.io/api/show-service/shows',
        queryParameters: {'category': '축구'},
      );

      if (response.statusCode == 200) {
        categoryList = response.data['content'];
        print('성공');
      }
    } catch (error) {
      print('Error while getting category list: $error');
    }
  }
}
