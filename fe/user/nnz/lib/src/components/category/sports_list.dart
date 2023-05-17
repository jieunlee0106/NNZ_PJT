import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nnz/src/components/category/categort_null.dart';
import 'package:nnz/src/components/category/sports_card.dart';
import 'package:nnz/src/components/icon_data.dart';
import 'package:nnz/src/components/nullPage.dart';
import 'package:nnz/src/config/config.dart';
import 'package:marquee/marquee.dart';
import 'package:nnz/src/components/category/show_card.dart';
import 'package:nnz/src/controller/category_controller.dart';
import 'package:nnz/src/model/sport_model.dart';

class SportsList extends StatefulWidget {
  final String sportsImg;
  final String sportName;

  const SportsList({
    Key? key,
    required this.sportsImg,
    required this.sportName,
  }) : super(key: key);

  @override
  _SportListState createState() => _SportListState();
}

class _SportListState extends State<SportsList> {
  final controller = Get.put(CategoryController());

  late SportModel sportList;
  late List<Content> items;

  Future<void> getList() async {
    await controller.getSportCategoryList(widget.sportName);
    sportList = controller.sportList;
    items = sportList.content;
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
              SizedBox(
                height: 8,
              ),
              Row(
                children: [
                  Image.asset(
                    widget.sportsImg,
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
              if (items.isEmpty)
                Center(
                  child: NullPage2(message: '공연 목록이 존재하지 않습니다'),
                )
              else
                Column(
                  children: items
                      .map((item) => SportsCard(
                            AteamLogo: item.leftTeamImage ?? '',
                            BteamLogo: item.rightTeamImage ?? '',
                            AteamName: item.leftTeam ?? '',
                            BteamName: item.rightTeam ?? '',
                            date: item.date.toString(),
                            location: item.location ?? '',
                            id: item.id ?? 0,
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
