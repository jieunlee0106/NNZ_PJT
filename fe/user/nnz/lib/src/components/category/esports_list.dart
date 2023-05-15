import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nnz/src/components/category/esports_card.dart';
import 'package:nnz/src/components/icon_data.dart';
import 'package:nnz/src/config/config.dart';
import 'package:marquee/marquee.dart';
import 'package:nnz/src/components/category/show_card.dart';
import 'package:nnz/src/controller/category_controller.dart';
import 'package:nnz/src/model/esport_model.dart';

class ESportsList extends StatefulWidget {
  final String sportsImg;
  final String sportName;

  const ESportsList({
    Key? key,
    required this.sportsImg,
    required this.sportName,
  }) : super(key: key);

  @override
  _EsportsListState createState() => _EsportsListState();
}


class _EsportsListState extends State<ESportsList> {
 final controller = Get.put(CategoryController());

  late EsportModel esportList;
  late List<Content> items;
  String categoryName = '리그 오브 레전드';
  

  Future<void> getList() async {
    await controller.getESportCategoryList(categoryName);
    esportList = controller.esportList;
    items = esportList.content;
  }

  @override
  void initState() {
    super.initState();
    if (widget.sportName == 'LCK') {
      categoryName = '리그 오브 레전드';
      getList();
    } else if (widget.sportName == 'OWL') {
      categoryName = '리그 오브 레전드';
      getList();
    } else  {
      categoryName = '리그 오브 레전드';
      getList();
    }

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
                
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [

                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    '경기 일정',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white70,
                      fontWeight: FontWeight.w600,
                    ),
                  ),                      Image(
                        image: AssetImage('assets/images/home/game.png'),
                        width: 35,
                        height: 35,
                      ),
                ],
              ),
              Column(
                children: items
                    .map((item) => EsportsCard(
                          AteamLogo: item.leftTeamImage ?? '',
                          BteamLogo: item.rightTeamImage ?? '',
                          AteamName: item.leftTeam ?? '',
                          BteamName: item.rightTeam ?? '',
                          date: item.date.toString(),
                          location: item.location ?? '서울 종로구',
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
