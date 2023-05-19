import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:nnz/src/components/home_page_form/event.dart';

import 'package:nnz/src/components/home_page_form/home_banner.dart';
import 'package:nnz/src/components/home_page_form/category_form.dart';
import 'package:nnz/src/components/home_page_form/hash_tag.dart';
import 'package:nnz/src/components/gray_line_form/gray_line.dart';
import 'package:nnz/src/components/home_page_form/home_festival.dart';
import 'package:nnz/src/components/home_page_form/home_info.dart';
import 'package:nnz/src/components/home_page_form/home_musical.dart';
import 'package:nnz/src/components/home_page_form/location_list.dart';
import 'package:nnz/src/components/home_page_form/share_text.dart';
import 'package:nnz/src/components/home_page_form/home_share_list.dart';
import 'package:nnz/src/components/home_page_form/baseball.dart';

import 'package:nnz/src/components/icon_data.dart';
import 'package:nnz/src/config/config.dart';
import 'package:nnz/src/controller/category_controller.dart';
import 'package:nnz/src/controller/home_controller.dart';
import 'package:nnz/src/controller/my_page_controller.dart';
import 'package:nnz/src/controller/sharing_register_controller.dart';
import 'package:nnz/src/model/hash_tag_model.dart';
import 'package:nnz/src/pages/category/concert.dart';
import 'package:nnz/src/pages/category/movie.dart';
import 'package:nnz/src/pages/category/musical.dart';
import 'package:nnz/src/pages/category/sports.dart';
import 'package:nnz/src/pages/category/esports.dart';
import 'package:nnz/src/pages/category/stage.dart';
import 'package:nnz/src/pages/home/loading.dart';
import 'package:nnz/src/pages/user/alarm.dart';
import 'package:nnz/src/model/popularity.dart';
import 'package:nnz/src/model/location_model.dart';
import 'package:nnz/src/pages/user/register.dart';
import 'package:permission_handler/permission_handler.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  // const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // const Home({Key? key}) : super(key: key);
  final HomeController controller = Get.put(HomeController());

  late List<HashTagModel> Tlist;
  late List<PopularityList> Plist;
  late LocationList locationList;

  bool permision = false;
  late double lng;
  late double lat;

  // late List<LoctaionList> Llist;
  bool _isLoading = true;
  bool _location = false;

  @override
  void initState() {
    super.initState();
    loadPData();
    loadTData();
    permission();
    print('홈 인잇스테이트');
  }

  Future<void> loadPData() async {
    await controller.getHomeList();
    Plist = controller.popularity;
    setState(() {
      _isLoading = true;
    });
  }

  Future<void> loadTData() async {
    await controller.getHashTag();
    Tlist = controller.hashTag;
    setState(() {
      _isLoading = true;
    });
  }

  Future<void> loadLData() async {
    await controller.getHomeLocationList(lng, lat);
    locationList = controller.locationList;
    setState(() {
      _isLoading = false;
    });
  }

  Future<bool> permission() async {
    Map<Permission, PermissionStatus> status =
        await [Permission.location].request();

    if (await Permission.location.isGranted) {
      getLocation();
      print('권한 허용');
      return Future.value(true);
    } else {
      lng = 37.57194990626231;
      lat = 126.97418466014994;
      return Future.value(false);
    }
  }

  Future<void> getLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    lng = position.longitude;
    lat = position.latitude;
    print(lat);
    print(lng);
    loadLData();
    setState(() {
      _location = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Center(
        child: Loading(),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          iconTheme: const IconThemeData(color: Colors.black),
          // leading: IconButton(
          //   icon: Icon(Icons.account_circle),
          //   onPressed: () {
          //     Navigator.push(
          //       context,
          //       MaterialPageRoute(
          //         builder: (context) => Register(),
          //       ),
          //     );
          //   },
          // ),
          title: Center(child: Image.asset(ImagePath.logo, width: 80)),
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
                      image: ImagePath.banner2,
                      num: 2382,
                    ),
                    HomeBanner(
                      image: ImagePath.banner3,
                      num: 2385,
                    ),
                    HomeBanner(
                      image: ImagePath.banner1,
                      num: 2381,
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
                        categoryListName: '콘서트',
                      ),
                      HomeCategory(
                          page: const MusicalPage(),
                          image: ImagePath.musical,
                          categoryName: '뮤지컬',
                          categoryListName: '뮤지컬'),
                      HomeCategory(
                        page: const StagePage(),
                        image: ImagePath.stage,
                        categoryName: '연극',
                        categoryListName: '연극',
                      ),
                      HomeCategory(
                        page: const MoviePage(),
                        image: ImagePath.movie,
                        categoryName: '페스티벌',
                        categoryListName: '뮤직 페스티벌',
                      ),
                      HomeCategory(
                          page: const SportsPage(),
                          image: ImagePath.sports,
                          categoryName: '스포츠',
                          categoryListName: '야구'),
                      HomeCategory(
                          page: const ESportsPage(),
                          image: ImagePath.esports,
                          categoryName: 'e스포츠',
                          categoryListName: '리그 오브 레전드'),
                    ],
                  ),
                ),
                GrayLine(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 24),
                      child: Image(
                        image: AssetImage('assets/images/party.png'),
                        width: 35,
                        height: 35,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 15,
                      ),
                      child: Text(
                        '  SSAFY 최종 발표 나눔 이벤트',
                        textAlign: TextAlign.left, // 수정된 부분
                        style: TextStyle(
                          color: Config.blackColor,
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 5),
                      child: Image(
                        image: AssetImage('assets/images/party1.png'),
                        width: 35,
                        height: 35,
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                // 발표 이벤트 베너
                CarouselWithIndicator(),
                GrayLine(),
                // 해시 태그
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
                HashTag(
                  items: Tlist,
                ),
                const SizedBox(height: 10),
                GrayLine(),
                // 나눔
                HomeShareText(
                  text: '인기 나눔',
                  image: ImagePath.fire,
                  smallText: '현재 가장 인기있는 나눔이에요',
                  plus: '',
                  page: Home(),
                ),
                HomeShareList(items: Plist),
                GrayLine(),
                HomeShareText(
                  text: '즉시 줄서기 가능한 나눔',
                  image: ImagePath.pin,
                  smallText: '근처에서 진행중인 나눔에 줄서기를 해보세요',
                  plus: '',
                  page: Home(),
                ),
                HomeShareList2(items: locationList.content),
                GrayLine(),
                // 야구 배너
                HomeShareText(
                  text: '오늘의 Sports',
                  image: ImagePath.sports,
                  smallText: '한화 이글스 VS LG 트윈스',
                  plus: '',
                  page: Home(),
                ),
                CarouselWithIndicator2(),
                GrayLine(),
                // 카테고리 인기공연
                HomeShareText(
                  text: '페스티벌',
                  image: ImagePath.movie,
                  smallText: '현재 공연 중인 페스티벌에 대한 나눔을 이용해보세요',
                  plus: '더보기 >',
                  page: MoviePage(),
                ),
                HoemCategoryList(categoryName: '뮤직페스티벌'),
                GrayLine(),
                HomeShareText(
                  text: '뮤지컬',
                  image: ImagePath.musical,
                  smallText: '현재 공연 중인 뮤지컬에 대한 나눔을 이용해보세요',
                  plus: '더보기 >',
                  page: MusicalPage(),
                ),
                HoemCategoryList(categoryName: '뮤지컬'),
                GrayLine(),
                HomeShareText(
                  text: '연극',
                  image: ImagePath.stage,
                  smallText: '현재 공연 중인 연극에 대한 나눔을 이용해보세요',
                  plus: '더보기 >',
                  page: StagePage(),
                ),
                HoemCategoryList(categoryName: '연극'),
                HomeShareText(
                  text: '콘서트',
                  image: ImagePath.concert,
                  smallText: '현재 공연 중인 콘서트에 대한 나눔을 이용해보세요',
                  plus: '더보기 >',
                  page: ConcertPage(),
                ),
                HoemCategoryList(categoryName: '연극'),
                HomeInfo()
              ],
            ),
          ),
        ),
      );
    }
  }
}
