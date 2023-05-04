import 'package:flutter/material.dart';
import 'package:nnz/src/config/config.dart';
import 'package:marquee/marquee.dart';

//**
//
// 이미지, text3, number API 데이터로 수정
//
//
//
//*/
class ShareList extends StatelessWidget {
  ShareList({Key? key}) : super(key: key);

  final List<Map<String, String>> _items = [
    {
      'image':
          'https://m.mondayfactory.co.kr/web/product/big/202202/a97bb63cf83efe18a9955b68d1476983.jpg',
      'title': '한화 이글스 굿즈 나눔!',
      'date': '2023.03.10',
      'status': '마감',
      'is_verified': 'false',
      'location': '대전 한화 이글스파크'
    },
    {
      'image':
          'https://www.thinkfood.co.kr/news/photo/202011/89224_115703_256.jpg',
      'title': '빙그레즈 나눔 나눔',
      'date': '2023.03.10',
      'status': '진행 전',
      'is_verified': 'flase',
      'location': '경기 고양시 일산 동구'
    },
    {
      'image':
          'https://pds.joongang.co.kr/news/component/htmlphoto_mmdata/202109/27/78c06661-48fb-4f72-8e9b-2c7bd6e0ba82.jpg',
      'date': '2023.03.10',
      'title': '매운 새우깡 손이가는 굿즈 나눔',
      'status': '진행중',
      'is_verified': 'true',
      'location': '공연 장소'
    },
    {
      'image':
          'https://blog.jandi.com/ko/wp-content/uploads/sites/4/2022/01/%EC%9E%94%EB%94%94%EA%B5%BF%EC%A6%88_%EC%A2%85%ED%95%A9%EB%AA%A9%EC%97%85-1.jpg',
      'title': '나눔 제목 적어요',
      'date': '2023.03.10',
      'is_verified': 'flase',
      'status': '마감',
      'location': '공연 장소 상암'
    },
    {
      'image':
          'https://image.newdaily.co.kr/site/data/img/2019/10/14/2019101400025_0.jpg',
      'title': '한화 이글스 굿즈 나눔',
      'date': '2023.03.10',
      'status': '진행중',
      'is_verified': 'true',
      'location': '공연 장소 상암'
    },
    {
      'image':
          'https://image.newdaily.co.kr/site/data/img/2019/10/14/2019101400025_0.jpg',
      'title': '한화 이글스 굿즈 나눔',
      'date': '2023.03.10',
      'status': '진행중',
      'is_verified': 'true',
      'location': '공연 장소 상암'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Column(
        children: _items
            .map(
              (item) => Container(
                width: 345,
                height: 150,
                margin: const EdgeInsets.only(top: 6),
                decoration: const BoxDecoration(),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 120,
                          height: 120,
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 255, 253, 253),
                            image: DecorationImage(
                              image: NetworkImage(item['image']!),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 5, left: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    width: 60,
                                    height: 22,
                                    decoration: BoxDecoration(
                                      color: Config.yellowColor,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Center(
                                      child: Text(
                                        item['status']!,
                                        style: TextStyle(
                                          color: Config.blackColor,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 12,
                                  ),
                                  Visibility(
                                    visible: item['is_verified'] == 'true',
                                    child: Container(
                                      width: 100,
                                      height: 22,
                                      decoration: BoxDecoration(
                                        color: Config.yellowColor,
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Center(
                                        child: Text(
                                          '인증 확인서 필요',
                                          style: TextStyle(
                                            color: Config.blackColor,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Center(
                                child: Text(
                                  item['title']!,
                                  style: TextStyle(
                                    color: Config.blackColor,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 7),
                              Text(
                                item['date']!,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Config.grayFontColor,
                                  fontWeight: FontWeight.w900,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 7),
                              Text(
                                item['location']!,
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Config.grayFontColor,
                                  fontWeight: FontWeight.w400,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Container(
                      height: 2,
                      width: 350,
                      decoration: BoxDecoration(
                        color: Config.greyColor,
                      ),
                    ),
                  ],
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
