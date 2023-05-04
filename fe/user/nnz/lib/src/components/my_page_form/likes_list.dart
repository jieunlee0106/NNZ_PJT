import 'package:flutter/material.dart';
import 'package:nnz/src/components/my_page_form/like_card.dart';

class LikesList extends StatefulWidget {
  const LikesList({Key? key}) : super(key: key);

  @override
  _LikesListState createState() => _LikesListState();
}

class _LikesListState extends State<LikesList> {
  final List<Map<String, String>> _items = [
    {
      'image':
          'https://m.mondayfactory.co.kr/web/product/big/202202/a97bb63cf83efe18a9955b68d1476983.jpg',
      'title': '한화 vs 키움',
      'subtitle': '직접만든 한화 류현진 응원봉',
      'location': '대전 한화 이글스파크'
    },
    {
      'image':
          'https://www.thinkfood.co.kr/news/photo/202011/89224_115703_256.jpg',
      'title': '2023 빙그레즈 단독 투어',
      'subtitle': '바나나빙그레 X 흑임자 비비빅 굿즈',
      'location': '경기 고양시 일산 동구'
    },
    {
      'image':
          'https://pds.joongang.co.kr/news/component/htmlphoto_mmdata/202109/27/78c06661-48fb-4f72-8e9b-2c7bd6e0ba82.jpg',
      'title': '공연 제목 입력란',
      'subtitle': '나눔 제목 입력란',
      'location': '공연 장소'
    },
    {
      'image':
          'https://m.mondayfactory.co.kr/web/product/big/202202/a97bb63cf83efe18a9955b68d1476983.jpg',
      'title': '한화 vs 키움',
      'subtitle': '직접만든 한화 류현진 응원봉',
      'location': '대전 한화 이글스파크'
    },
    {
      'image':
          'https://pds.joongang.co.kr/news/component/htmlphoto_mmdata/202109/27/78c06661-48fb-4f72-8e9b-2c7bd6e0ba82.jpg',
      'title': '공연 제목 입력란',
      'subtitle': '나눔 제목 입력란',
      'location': '공연 장소'
    },
    {
      'image':
          'https://m.mondayfactory.co.kr/web/product/big/202202/a97bb63cf83efe18a9955b68d1476983.jpg',
      'title': '한화 vs 키움',
      'subtitle': '직접만든 한화 류현진 응원봉',
      'location': '대전 한화 이글스파크'
    },
    {
      'image':
          'https://pds.joongang.co.kr/news/component/htmlphoto_mmdata/202109/27/78c06661-48fb-4f72-8e9b-2c7bd6e0ba82.jpg',
      'title': '공연 제목 입력란',
      'subtitle': '나눔 제목 입력란',
      'location': '공연 장소'
    },
    {
      'image':
          'https://m.mondayfactory.co.kr/web/product/big/202202/a97bb63cf83efe18a9955b68d1476983.jpg',
      'title': '한화 vs 키움',
      'subtitle': '직접만든 한화 류현진 응원봉',
      'location': '대전 한화 이글스파크'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      crossAxisCount: 2,
      mainAxisSpacing: 16,
      crossAxisSpacing: 16,
      childAspectRatio: 0.75,
      children: _items
          .map(
            (item) => LikeCard(
              image: item['image']!,
              title: item['title']!,
              subtitle: item['subtitle']!,
              location: item['location']!,
            ),
          )
          .toList(),
    );
  }
}
