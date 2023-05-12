import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nnz/src/components/icon_data.dart';
import 'package:nnz/src/config/config.dart';
import 'package:marquee/marquee.dart';
import 'package:nnz/src/components/category/show_card.dart';
import 'package:nnz/src/controller/category_controller.dart';
import 'package:nnz/src/model/show_category_model.dart';

class ShowList extends StatefulWidget {
  final category;
  const ShowList({
    Key? key,
    required this.category,
  }) : super(key: key);

  @override
  _ShowListState createState() => _ShowListState();
}

class _ShowListState extends State<ShowList> {
  final controller = Get.put(CategoryController());

  late List<ShowCategory> items;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    getList();
  }

  Future<void> getList() async {
    await controller.getShowCategoryList(widget.category);
    // items = controller.showCategory;
    // print(likes.id);
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Image.asset(
                  ImagePath.gift,
                  width: 35,
                ),
                SizedBox(
                  width: 6,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '공연  목록',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text('공연에 대한 나눔을 확인해 보세요'),
                  ],
                ),
              ],
            ),
          ),
          // Column(
          //   children: widget.items
          //       .map(
          //         (item) => ShowCard(
          //             image: item.content?.poster!,
          //             title: item['title']!,
          //             date: item['date']!,
          //             location: item['location']!),
          //       )
          //       .toList(),
          // ),
        ],
      ),
    );
  }
}
