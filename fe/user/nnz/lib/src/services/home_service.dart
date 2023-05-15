import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart';
import 'package:nnz/src/controller/bottom_nav_controller.dart';

class HomeService extends GetConnect {
  final dio = Dio();

  @override
  void onInit() async {
    await dotenv.load();
    // dio.options.baseUrl = dotenv.env['BASE_URL'];

    // dio.options.connectTimeout = timeout;
    super.onInit();
  }

  Future<dynamic> getHomeInfo() async {
    try {
      final response = await dio.get(
        'https://k8b207.p.ssafy.io/api/nanum-service/nanums/popular',
      );
      return response;
    } catch (e) {
      print('Error occurred: $e');
      throw e;
    }
  }

  Future<dynamic> getHashTag() async {
    try {
      final response = await dio.get(
        'https://k8b207.p.ssafy.io/api/tag-service/tags',
      );
      return response;
    } catch (e) {
      print('Error occurred: $e');
      throw e;
    }
  }

  //   Future<dynamic> getLocationInfo() async {
  //   try {
  //     final response = await dio.get(
  //       'https://k8b207.p.ssafy.io/api/nanum-service/nanums/popular',
  //     );
  //     return response;
  //   } catch (e) {
  //     print('####Error occurred: $e');
  //     throw e;
  //   }
  // }
}
