import 'package:get/get.dart';

import 'package:nnz/src/services/category_service.dart';

class CategoryController extends GetxController {
  var categoryList =[];

  getCategoryList() async {
    try {
      final data = await CategoryService().getCategoryList(categoryName: '야구');
      // categoryList.assignAll(data.date['content']);
      print(data.data['content']);
      categoryList = data.data['content'];
      // assignAll 메소드는 RxList에 새로운 요소를 추가하고, 리스트를 업데이트합니다.
    } catch (e) {
      print(e);
    }
  }
}
