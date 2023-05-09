import 'package:get/get.dart';
import 'package:nnz/src/services/category_service.dart';

class CategoryController extends GetxController {
  final CategoryService _categoryService = Get.put(CategoryService());

  Rx<List<dynamic>> categoryList = Rx<List<dynamic>>([]);

  Future<void> getCategoryList() async {
    final response = await _categoryService.getCategoryList();
    if (response == null) {
      print("error");
    } else {
      print(response.data['content']);
      categoryList.value = response.data['content'];
      print("!!!!!!!!!!!!!!!!!!!!!!!!!성공!!!");
      return response;
    }
  }

  // try {
  //   final response = await get("/show?=$category", headers: headers);
  //   if (response.statusCode == 200) {
  //     return response.body;
  //   } else {
  //     final errorMessage = "(${response.statusCode}): ${response.body}";
  //     logger.e(errorMessage);
  //     throw Exception(errorMessage);
  //   }
  // } catch (e) {
  //   final errorMessage = "$e";
  //   logger.e(errorMessage);
  //   throw Exception(errorMessage);
  // }
}
