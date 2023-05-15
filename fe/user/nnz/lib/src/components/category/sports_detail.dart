import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nnz/src/components/category/category_dropdown.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:nnz/src/components/category/sports_list.dart';
import 'package:nnz/src/components/category/sports_schedule.dart';
import 'package:nnz/src/components/icon_data.dart';
import 'package:nnz/src/components/gray_line_form/gray_line.dart';
import 'package:nnz/src/controller/category_controller.dart';

class SportsBanner extends StatefulWidget {
  const SportsBanner({Key? key}) : super(key: key);

  @override
  _SportsBannerState createState() => _SportsBannerState();
}

class _SportsBannerState extends State<SportsBanner> {
  String sportEventB = ImagePath.bsbB;
  String sportsName = '야구';
  String sportsNameR = '농구';
  String sportsNameL = '축구';
  String league = 'KBO';
  String startDate = '2023.04.01';
  String endDate = '미정';
  String sportsImg = ImagePath.bsbIcon;
  String now = '';

  final List<String> _sports = [
    '야구',
    '축구',
    '농구',
  ];

  final CategoryController categoryController = Get.find<CategoryController>();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          child: Stack(
            // alignment: Alignment(0, -0.68),
            children: [
              Container(
                height: 200,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(sportEventB),
                      alignment: Alignment.topCenter),
                ),
              ),
              Container(
                child: CarouselSlider(
                  options: CarouselOptions(
                    height: 100,
                    enableInfiniteScroll: false,
                    enlargeCenterPage: false,
                    reverse: true,
                    viewportFraction: 1,
                  ),
                  items: _sports.map((text) {
                    return Builder(
                      builder: (BuildContext context) {
                        Future<void> updateSportSportName() async {}
                        String sportsName;
                        String sportsNameR;
                        String sportsNameL;
                        if (sportEventB == ImagePath.bsbB) {
                          sportsName = _sports[0];
                          sportsNameR = _sports[1];
                          sportsNameL = _sports[2];
                        } else if (sportEventB == ImagePath.socB) {
                          sportsName = _sports[1];
                          sportsNameR = _sports[2];
                          sportsNameL = _sports[0];
                        } else {
                          sportsName = _sports[2];
                          sportsNameR = _sports[0];
                          sportsNameL = _sports[1];
                        }
                        return Container(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 40),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      sportsName,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 30,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      sportsNameL,
                                      style: TextStyle(
                                        color: Colors.white70,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Text(
                                      sportsNameR,
                                      style: TextStyle(
                                        color: Colors.white70,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  }).toList(),
                ),
              ),
              Column(
                children: [
                  SizedBox(
                    height: 80,
                  ),
                  Container(
                    height: 200,
                    child: CarouselSlider(
                      options: CarouselOptions(
                        height: 200,
                        // autoPlay: true,
                        enlargeCenterPage: true,
                        enableInfiniteScroll: true,
                        viewportFraction: 0.78,
                        onPageChanged: (int index, _) {
                          setState(() {
                            if (index == 0) {
                              sportEventB = ImagePath.bsbB;
                              league = 'KBO';
                              startDate = '2023.04.01';
                              endDate = '미정';
                              sportsImg = ImagePath.bsbIcon;
                            } else if (index == 1) {
                              sportEventB = ImagePath.socB;
                              league = 'Kleague';
                              startDate = '2023.02.25';
                              endDate = '미정';
                              sportsImg = ImagePath.socIcon;
                            } else {
                              sportEventB = ImagePath.bkbB;
                              league = 'KBL';
                              startDate = '2023.04.02';
                              endDate = '미정';
                              sportsImg = ImagePath.bkbIcon;
                            }
                          });
                        },
                      ),
                      items: _sports.map((image) {
                        return Builder(
                          builder: (BuildContext context) {
                            int index = _sports.indexOf(image);
                            String carouselImage;
                            if (index == 0) {
                              carouselImage = ImagePath.bsbC;
                              league = 'KBO';
                              startDate = '2023.04.02';
                              endDate = '2023.04.12';
                              sportsImg = ImagePath.bsbIcon;
                              sportsName = '야구';
                            } else if (index == 1) {
                              carouselImage = ImagePath.socC;
                              league = 'Kleague';
                              startDate = '2023.04.02';
                              endDate = '2023.04.12';
                              sportsImg = ImagePath.socIcon;
                              sportsName = '축구';
                            } else {
                              carouselImage = ImagePath.bkbC;
                              league = 'KBL';
                              startDate = '2023.04.02';
                              endDate = '2023.04.12';
                              sportsImg = ImagePath.bkbIcon;
                              sportsName = '농구';
                            }
                            return Container(
                              width: MediaQuery.of(context).size.width,
                              margin: EdgeInsets.symmetric(horizontal: 10.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                image: DecorationImage(
                                  image: AssetImage(carouselImage),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            );
                          },
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(
          height: 12,
        ),
        GrayLine(),
        SportsSchedule(
          league: league,
          startDate: startDate,
          endDate: endDate,
        ),
        GrayLine(),
        SportsList(
          sportsImg: sportsImg,
          sportName: sportsName,
        ),
      ],
    );
  }
}
