import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nnz/src/controller/category_controller.dart';

class NotificationPage extends StatelessWidget {
  final categoryController = Get.put(CategoryController());

  void test() {
    final ll = categoryController.categoryList;
    print(ll);
    Get.to(() => CategoryListScreen(categoryList: ll));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Category List"),
      ),
      body: Center(
        child: ElevatedButton(
          child: Text("Fetch Categories"),
          onPressed: () {
            categoryController.getCategoryList();
            test();
          },
        ),
      ),
    );
  }
}

class CategoryListScreen extends StatelessWidget {
  final List<dynamic> categoryList;

  const CategoryListScreen({Key? key, required this.categoryList})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Category List"),
      ),
      body: ListView.builder(
        itemCount: categoryList.length,
        itemBuilder: (BuildContext context, int index) {
          final category = categoryList[index];
          return Card(
            child: ListTile(
              title: Text(category['date']),
              subtitle: Text(category['rightTeam'] + category['location']),
            ),
          );
        },
      ),
    );
  }
}
