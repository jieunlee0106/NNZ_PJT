import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nnz/src/components/category/esports_list.dart';
import 'package:nnz/src/controller/category_controller.dart';

class HomeCategory extends StatelessWidget {
  final String categoryName;
  final String image;
  final String categoryListName;
  final Widget page;
  final CategoryController categoryController = Get.put(CategoryController());

  HomeCategory({
    super.key,
    required this.image,
    required this.categoryName,
    required this.categoryListName,
    required this.page,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        await categoryController.getShowCategoryList(categoryListName);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => page),
        );
      },
      child: SizedBox(
        height: 60,
        width: 60,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Image(
                        image: AssetImage(image),
                        width: 35,
                        height: 35,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(2),
                        child: Text(categoryName),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
