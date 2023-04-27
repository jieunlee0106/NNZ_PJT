import 'package:flutter/material.dart';

import 'package:carousel_slider/carousel_slider.dart';
// import 'package:get/get.dart';
import 'package:nnz/src/components/home_page_form/home_banner.dart';
import 'package:nnz/src/components/home_page_form/category_form.dart';
import 'package:nnz/src/components/home_page_form/hash_tag.dart';
import 'package:nnz/src/components/gray_line_form/gray_line.dart';
import 'package:nnz/src/components/home_page_form/share_text.dart';
import 'package:nnz/src/components/home_page_form/home_share_list.dart';

import 'package:nnz/src/components/icon_data.dart';
import 'package:nnz/src/config/config.dart';

import 'package:nnz/src/pages/category/concert.dart';
import 'package:nnz/src/pages/category/movie.dart';
import 'package:nnz/src/pages/category/musical.dart';
import 'package:nnz/src/pages/category/sports.dart';
import 'package:nnz/src/pages/category/esports.dart';
import 'package:nnz/src/pages/category/stage.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          iconTheme: const IconThemeData(color: Colors.black),
          leading: const Icon(Icons.account_circle),
          title: Center(child: Image.asset(ImagePath.logo, width: 80)),
          actions: const [Icon(Icons.notifications)],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Column(
              children: [
                CarouselSlider(
                  options: CarouselOptions(
                    height: 200.0,
                    autoPlay: true,
                    enlargeCenterPage: true,
                    aspectRatio: 16 / 9,
                    autoPlayCurve: Curves.fastOutSlowIn,
                    enableInfiniteScroll: true,
                    autoPlayAnimationDuration:
                        const Duration(milliseconds: 800),
                    viewportFraction: 0.8,
                  ),
                  items: [
                    HomeBanner(
                      image: ImagePath.banner1,
                      num: 1,
                    ),
                    HomeBanner(
                      image: ImagePath.banner2,
                      num: 1,
                    ),
                    HomeBanner(
                      image: ImagePath.banner3,
                      num: 1,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      HomeCategory(
                          page: const ConcertPage(),
                          image: ImagePath.concert,
                          categoryName: '콘서트',
                          num: 1),
                      HomeCategory(
                          page: const musicalPage(),
                          image: ImagePath.musical,
                          categoryName: '뮤지컬',
                          num: 1),
                      HomeCategory(
                        page: const stagePage(),
                        image: ImagePath.stage,
                        categoryName: '연극',
                        num: 1,
                      ),
                      HomeCategory(
                        page: const moviePage(),
                        image: ImagePath.movie,
                        categoryName: '영화',
                        num: 1,
                      ),
                      HomeCategory(
                          page: const sportsPage(),
                          image: ImagePath.sports,
                          categoryName: '스포츠',
                          num: 1),
                      HomeCategory(
                          page: const esportsPage(),
                          image: ImagePath.esports,
                          categoryName: 'e스포츠',
                          num: 1),
                    ],
                  ),
                ),
                GrayLine(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 15,
                      ),
                      child: Text(
                        '# 현재 가장 인기있는 해시태그',
                        textAlign: TextAlign.left, // 수정된 부분
                        style: TextStyle(
                          color: Config.blackColor,
                          fontSize: 18,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                  ],
                ),
                const HashTag(),
                const SizedBox(height: 10),
                GrayLine(),
                HomeShareText(
                    text: '즉시 줄서기 가능한 나눔',
                    image: ImagePath.pin,
                    smallText: '근처에서 진행중인 나눔에 줄서기를 해보세요'),
                HomeShareList(),
                GrayLine(),
                HomeShareText(
                    text: '인기 나눔',
                    image: ImagePath.fire,
                    smallText: '현재 가장 인기있는 나눔이에요'),
                HomeShareList(),
                // Add other widgets here...
              ],
            ),
          ),
        ));
  }
}
