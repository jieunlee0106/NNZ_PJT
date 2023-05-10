import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nnz/src/components/category/sports_card.dart';
import 'package:nnz/src/components/icon_data.dart';
import 'package:nnz/src/config/config.dart';
import 'package:marquee/marquee.dart';
import 'package:nnz/src/components/category/show_card.dart';
import 'package:nnz/src/controller/category_controller.dart';

class SportsList extends StatelessWidget {
  final String sportsImg;
  final String sportName;
  final CategoryController categoryController = Get.find<CategoryController>();

  SportsList({
    required this.sportsImg,
    required this.sportName,
    Key? key,
  }) : super(key: key);

  // void temp() {}
  // void getItems() {
  //   final List<dynamic> _items = categoryController.categoryList;
  // }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CategoryController>(
      builder: (categoryController) {
        print(sportName);

        final List<dynamic> _items = categoryController.categoryList;
        print(_items);

        if (_items.isEmpty) {
          print('비었음');
        }
        // print(_items);
        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 8,
              ),
              Row(
                children: [
                  Image.asset(
                    sportsImg,
                    width: 30,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    '경기 일정',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              Column(
                children: _items
                    .map((item) => SportsCard(
                          AteamLogo: item['leftTeam']!,
                          BteamLogo: item['leftTeam']!,
                          AteamName: item['leftTeam']!,
                          BteamName: item['leftTeam']!,
                          date: item['date']!,
                          location: item['location']!,
                        ))
                    .toList(),
              ),
              SizedBox(
                height: 10,
              ),
            ],
          ),
        );
      },
    );
  }
}
