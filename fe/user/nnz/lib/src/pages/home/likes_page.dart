import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nnz/src/components/category/category_dropdown.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:nnz/src/components/category/sports_list.dart';
import 'package:nnz/src/components/category/sports_schedule.dart';
import 'package:nnz/src/components/icon_data.dart';
import 'package:nnz/src/components/gray_line_form/gray_line.dart';
import 'package:nnz/src/components/my_page_form/likes_list.dart';
import 'package:nnz/src/config/config.dart';
import 'package:nnz/src/controller/likes_controller.dart';
import 'package:nnz/src/model/likes_model.dart';
import 'package:nnz/src/model/mypage_model.dart';

class LikesPage extends StatefulWidget {
  const LikesPage({Key? key}) : super(key: key);

  @override
  _LikesPageState createState() => _LikesPageState();
}

class _LikesPageState extends State<LikesPage> {
  final likesController = Get.put(LikesController());

  late Likes likes;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    loadLikeList();
  }

  Future<void> loadLikeList() async {
    await likesController.getLikesList();
    likes = likesController.likes;
    print(likes);
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.black),
          title: Center(child: Image.asset(ImagePath.logo, width: 80)),
          actions: [Icon(Icons.more_vert)],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 20,
              horizontal: 10,
            ),
            child: Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Image.asset(
                        ImagePath.heart,
                        width: 30,
                      ),
                      Text(
                        ' 관심 목록',
                        style: TextStyle(
                          fontSize: 22,
                          color: Config.blackColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 8,
                      bottom: 10,
                    ),
                    child: Container(
                      width: 140,
                      height: 2,
                      decoration: BoxDecoration(
                        color: Config.greyColor,
                      ),
                    ),
                  ),
                  Text(
                    '관심있는 나눔 목록을 확인해 보세요❤',
                    style: TextStyle(
                      fontSize: 12,
                    ),
                  ),
                  // LikesList(items: likes. ?? []),
                ],
              ),
            ),
          ),
        ));
  }
}
