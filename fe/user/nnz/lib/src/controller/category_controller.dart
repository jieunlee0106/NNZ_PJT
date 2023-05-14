import 'package:get/get.dart';
import 'package:nnz/src/controller/sharing_register_controller.dart';

import 'package:nnz/src/services/category_service.dart';

class CategoryController extends GetxController {
  var categoryList = [];
  final token = SharingRegisterController().getToken();

  getCategoryList(String categoryName) async {
    try {
      final data =
          await CategoryService().getCategoryList(categoryName: categoryName);
      // categoryList.assignAll(data.date['content']);
      // print(data.data['content']);
      print('API 통신 중~~~~~~~~~~~~~~$categoryName');
      categoryList = data.data['content'];
      print('$token !!!!!!!!!');
      return categoryList.toList();

      // print('할당 완');
      // assignAll 메소드는 RxList에 새로운 요소를 추가하고, 리스트를 업데이트합니다.
    } catch (e) {
      print(e);
    }
  }
}
