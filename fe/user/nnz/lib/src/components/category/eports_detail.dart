import 'package:flutter/material.dart';
import 'package:nnz/src/components/category/category_dropdown.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:nnz/src/components/category/esports_list.dart';
import 'package:nnz/src/components/category/sports_list.dart';
import 'package:nnz/src/components/category/sports_schedule.dart';
import 'package:nnz/src/components/icon_data.dart';
import 'package:nnz/src/components/gray_line_form/gray_line.dart';

class EsportsBanner extends StatefulWidget {
  const EsportsBanner({Key? key}) : super(key: key);

  @override
  _EsportsBannerState createState() => _EsportsBannerState();
}

class _EsportsBannerState extends State<EsportsBanner> {
  String esportEventB = ImagePath.lolB;
  String esportsName = 'LCK';
  String esportsNameR = 'OWL';
  String esportsNameL = 'KDL';
  String img = ImagePath.esports;

  final List<String> _sports = ['LCK', 'OWL', 'GSL', 'KDL'];

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
                height: 2900,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(esportEventB),
                      alignment: Alignment.topCenter),
                ),
              ),
              Container(
                child: CarouselSlider(
                  options: CarouselOptions(
                    height: 100,
                    enableInfiniteScroll: false,
                    enlargeCenterPage: false,
                    viewportFraction: 1,
                  ),
                  items: _sports.map((text) {
                    return Builder(
                      builder: (BuildContext context) {
                        String esportsName;
                        String esportsNameR;
                        String esportsNameL;
                        if (esportEventB == ImagePath.lolB) {
                          esportsName = _sports[0];
                          esportsNameR = _sports[1];
                          esportsNameL = _sports[2];
                        } else if (esportEventB == ImagePath.oveB) {
                          esportsName = _sports[1];
                          esportsNameR = _sports[2];
                          esportsNameL = _sports[0];
                        } else if (esportEventB == ImagePath.staB) {
                          esportsName = _sports[2];
                          esportsNameR = _sports[3];
                          esportsNameL = _sports[1];
                        } else {
                          esportsName = _sports[3];
                          esportsNameR = _sports[0];
                          esportsNameL = _sports[2];
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
                                      esportsName,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 35,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      esportsNameL,
                                      style: TextStyle(
                                        color: Colors.white70,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Text(
                                      esportsNameR,
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
                              esportEventB = ImagePath.lolB;
                            } else if (index == 1) {
                              esportEventB = ImagePath.oveB;
                            } else if (index == 2) {
                              esportEventB = ImagePath.staB;
                            } else {
                              esportEventB = ImagePath.karB;
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
                              carouselImage = ImagePath.lol;
                            } else if (index == 1) {
                              carouselImage = ImagePath.ove;
                            } else if (index == 2) {
                              carouselImage = ImagePath.sta;
                            } else {
                              carouselImage = ImagePath.kar;
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
                  EsportsList(sportsImg: img)
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
