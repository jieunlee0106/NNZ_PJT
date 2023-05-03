import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nnz/src/config/config.dart';

class SearchShow extends StatelessWidget {
  const SearchShow({super.key});

  @override
  Widget build(BuildContext context) {
    final postIndex = [
      'https://img.khan.co.kr/news/2022/11/13/news-p.v1.20221113.d7705974a42f4bbda8eea85b38d28a7f_P1.jpg',
      'https://img.khan.co.kr/news/2022/11/13/news-p.v1.20221113.d7705974a42f4bbda8eea85b38d28a7f_P1.jpg',
      'https://img.khan.co.kr/news/2022/11/13/news-p.v1.20221113.d7705974a42f4bbda8eea85b38d28a7f_P1.jpg',
      'https://img.khan.co.kr/news/2022/11/13/news-p.v1.20221113.d7705974a42f4bbda8eea85b38d28a7f_P1.jpg',
      'https://img.khan.co.kr/news/2022/11/13/news-p.v1.20221113.d7705974a42f4bbda8eea85b38d28a7f_P1.jpg',
      'https://img.khan.co.kr/news/2022/11/13/news-p.v1.20221113.d7705974a42f4bbda8eea85b38d28a7f_P1.jpg',
      'https://img.khan.co.kr/news/2022/11/13/news-p.v1.20221113.d7705974a42f4bbda8eea85b38d28a7f_P1.jpg',
      'https://img.khan.co.kr/news/2022/11/13/news-p.v1.20221113.d7705974a42f4bbda8eea85b38d28a7f_P1.jpg',
    ];
    final showTitle = [
      '2023 백예린 단독 공연',
      '2023 백예린 단독 공연',
      '2023 백예린 단독 공연',
      '2023 백예린 단독 공연',
      '2023 백예린 단독 공연',
      '2023 백예린 단독 공연',
      '2023 백예린 단독 공연',
      '2023 백예린 단독 공연',
    ];
    final tag = [
      'Square',
      'Square',
      'Square',
      'Square',
      'Square',
      'Square',
      'Square',
      'Square',
    ];
    final showStartTime = [
      '2023.05.19',
      '2023.05.19',
      '2023.05.19',
      '2023.05.19',
      '2023.05.19',
      '2023.05.19',
      '2023.05.19',
      '2023.05.19',
    ];
    final showEndTime = [
      '2023.05.21',
      '2023.05.21',
      '2023.05.21',
      '2023.05.21',
      '2023.05.21',
      '2023.05.21',
      '2023.05.21',
      '2023.05.21',
    ];
    final venue = [
      '올림픽공원 SK핸드볼 경기장',
      '올림픽공원 SK핸드볼 경기장',
      '올림픽공원 SK핸드볼 경기장',
      '올림픽공원 SK핸드볼 경기장',
      '올림픽공원 SK핸드볼 경기장',
      '올림픽공원 SK핸드볼 경기장',
      '올림픽공원 SK핸드볼 경기장',
      '올림픽공원 SK핸드볼 경기장',
    ];
    return SizedBox(
      height: Get.width * 0.85,
      child: ListView.builder(
        physics: const AlwaysScrollableScrollPhysics(),
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: venue.length,
        itemBuilder: ((context, index) {
          return Container(
            padding: const EdgeInsets.symmetric(
              vertical: 10,
            ),
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      offset: const Offset(0, 4),
                      blurRadius: 4,
                      color: Colors.black.withOpacity(0.25),
                    )
                  ]),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 200,
                    child: Image.network(
                      postIndex[index],
                    ),
                  ),
                  const SizedBox(
                    width: 18,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 16,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          showTitle[index],
                          style: TextStyle(
                            fontSize: 18,
                            color: Config.blackColor,
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Text(
                          "<${tag[index]}>",
                          style: TextStyle(
                            fontSize: 18,
                            color: Config.blackColor,
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        const Text("공연기간"),
                        const SizedBox(
                          height: 4,
                        ),
                        Row(
                          children: [
                            Text(showStartTime[index]),
                            const Text("~"),
                            Text(showEndTime[index]),
                          ],
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        const Text("공연장소"),
                        const SizedBox(
                          height: 4,
                        ),
                        Text(venue[index]),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
