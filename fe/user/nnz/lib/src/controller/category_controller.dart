import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nnz/src/components/category/show_list.dart';
import 'package:nnz/src/model/esport_model.dart';
import 'package:nnz/src/model/hot_list.dart';
import 'package:nnz/src/model/show_list_model.dart';
import 'package:nnz/src/controller/sharing_register_controller.dart';
import 'package:nnz/src/model/sport_model.dart';

import 'package:nnz/src/services/category_service.dart';

class CategoryController extends GetxController {
  // final token = SharingRegisterController().getToken();
  late ShowListModel showList;
  late SportModel sportList;
  late EsportModel esportList;
  late HotList hotList;

  // 뮤지컬, 연극, 콘서트, 뮤직 페스티벌
  getShowCategoryList(String categoryName) async {
    try {
      final response = await CategoryService()
          .getShowCategoryList(categoryName: categoryName);
      print('API 통신 중~~~$categoryName');

      showList = ShowListModel.fromJson(response.data);
      print('값 할당');
    } catch (e) {
      print(e);
    }
  }

  // sport
  getSportCategoryList(String categoryName) async {
    try {
      final response =
          await CategoryService().getCategoryList(categoryName: categoryName);
      print(response);
      print(categoryName);
      sportList = SportModel.fromJson(response.data);
      print('값 할당');
    } catch (e) {
      print(e);
    }
  }

    // e-sport
  getESportCategoryList(String categoryName) async {
    try {
      final response =
          await CategoryService().getCategoryList(categoryName: categoryName);
      print(response);
      print(categoryName);
      esportList = EsportModel.fromJson(response.data);
      print('값 할당');
    } catch (e) {
      print(e);
    }
  }

  // Hot 한 공연
  getHotList(String categoryName) async {
    try {
      final response =
          await CategoryService().getHotList(categoryName: categoryName);
      print('API 통신 중~~~$categoryName');

      showList = ShowListModel.fromJson(response.data);
      print('값 할당');
    } catch (e) {
      print(e);
    }
  }
}
