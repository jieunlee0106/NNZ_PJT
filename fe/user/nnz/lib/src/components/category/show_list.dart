import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nnz/src/components/category/show_null_page.dart';
import 'package:nnz/src/components/icon_data.dart';
import 'package:nnz/src/components/nullPage.dart';
import 'package:nnz/src/config/config.dart';
import 'package:marquee/marquee.dart';
import 'package:nnz/src/components/category/show_card.dart';
import 'package:nnz/src/controller/category_controller.dart';
import 'package:nnz/src/model/show_list_model.dart';

class ShowList extends StatefulWidget {
  final String categoryName;

  const ShowList({
    Key? key,
    required this.categoryName,
  }) : super(key: key);

  @override
  _ShowListState createState() => _ShowListState();
}

class _ShowListState extends State<ShowList> {
  final controller = Get.put(CategoryController());
  late ShowListModel showList;
  late List<Content> items;

  Future<void> getList() async {
    await controller.getShowCategoryList(widget.categoryName);
    showList = controller.showList;
    print(showList.content.runtimeType);
    items = showList.content;
    print(items);
  }

  @override
  void initState() {
    super.initState();
    getList();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getList(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (ConnectionState.waiting == snapshot.connectionState) {
            return const CircularProgressIndicator();
          }
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
                if (items.length == 0)
                  Center(
                    child: NullPage3(message: '공연 목록이 존재하지 않습니다'),
                  )
                else
                  Column(
                    children: items
                        .map(
                          (item) => ShowCard(
                            image: item.poster,
                            title: item.title,
                            startDate: item.startDate,
                            endDate: item.endDate,
                            location: item.location,
                          ),
                        )
                        .toList(),
                  ),
              ],
            ),
          );
        });
  }
}
