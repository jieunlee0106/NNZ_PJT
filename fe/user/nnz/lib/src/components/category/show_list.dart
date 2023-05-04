import 'package:flutter/material.dart';
import 'package:nnz/src/components/icon_data.dart';
import 'package:nnz/src/config/config.dart';
import 'package:marquee/marquee.dart';
import 'package:nnz/src/components/category/show_card.dart';

class ShowList extends StatelessWidget {
  ShowList({Key? key}) : super(key: key);

  final List<Map<String, String>> _items = [
    {
      'image':
          'https://ticketimage.interpark.com/Play/image/large/23/23005010_p.gif',
      'title': '2023 백예린 단독 공연<square>',
      'date': '2023.03.10 ~ 2023.05.10',
      'location': '올림픽 공원 SK핸드볼 경기장'
    },
    {
      'image':
          'https://ticketimage.interpark.com/Play/image/large/23/23005708_p.gif',
      'title': '현대카드 슈퍼콘서트 27 브루노 마스(Bruno Mars)',
      'date': '2023.06.17 ~2023.06.18',
      'location': '서울 잠실종합운동장 올림픽주경기장'
    },
    {
      'image':
          'https://ticketimage.interpark.com/Play/image/large/23/23005010_p.gif',
      'title': '2023 백예린 단독 공연<square>',
      'date': '2023.03.10 ~ 2023.05.10',
      'location': '올림픽 공원 SK핸드볼 경기장'
    },
    {
      'image':
          'https://ticketimage.interpark.com/Play/image/large/23/23005708_p.gif',
      'title': '현대카드 슈퍼콘서트 27 브루노 마스(Bruno Mars)',
      'date': '2023.06.17 ~2023.06.18',
      'location': '서울 잠실종합운동장 올림픽주경기장'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Image.asset(
                  ImagePath.gift,
                  width: 35,
                ),
                SizedBox(
                  width: 6,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '공연  목록',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text('공연에 대한 나눔을 확인해 보세요'),
                  ],
                ),
              ],
            ),
          ),
          Column(
            children: _items
                .map(
                  (item) => ShowCard(
                      image: item['image']!,
                      title: item['title']!,
                      date: item['date']!,
                      location: item['location']!),
                )
                .toList(),
          ),
        ],
      ),
    );
  }
}
