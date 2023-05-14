import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nnz/src/components/category/show_list.dart';
import 'package:nnz/src/model/show_list_model.dart';
import 'package:nnz/src/controller/sharing_register_controller.dart';

import 'package:nnz/src/services/category_service.dart';

class CategoryController extends GetxController {
  var categoryList = [];
  // final token = SharingRegisterController().getToken();
  late ShowListModel showList;

  // sport
  getCategoryList(String categoryName) async {
    try {
      final response =
          await CategoryService().getCategoryList(categoryName: categoryName);
      print(response);
      // categoryList = data.data['content'];
      return categoryList.toList();
    } catch (e) {
      print(e);
    }
  }

  // 뮤지컬, 연극, 콘서트, 뮤직 페스티벌
  getShowCategoryList(String categoryName) async {
    try {
      final response = await CategoryService()
          .getShowCategoryList(categoryName: categoryName);
      print('API 통신 중~~~$categoryName');

      showList = ShowListModel.fromJson(response.data);
      print('값 할당');
      return categoryList.toList();
    } catch (e) {
      print(e);
    }
  }
}
