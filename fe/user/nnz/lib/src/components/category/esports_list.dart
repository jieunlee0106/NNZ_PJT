import 'package:flutter/material.dart';
import 'package:nnz/src/components/category/esports_card.dart';
import 'package:nnz/src/components/icon_data.dart';
import 'package:nnz/src/config/config.dart';
import 'package:marquee/marquee.dart';
import 'package:nnz/src/components/category/show_card.dart';

class EsportsList extends StatelessWidget {
  final String sportsImg;

  EsportsList({
    super.key,
    required this.sportsImg,
  });

  final List<Map<String, String>> _items = [
    {
      'AteamLogo': '한화 이미지',
      'BteamLogo': '롯데 이미지',
      'AteamName': '한화',
      'BteamName': '롯데',
      'date': '2023-05-03',
      'location': '대전'
    },
    {
      'AteamLogo': 'Ateamlogo',
      'BteamLogo': 'BteamLogo',
      'AteamName': 'AteamName',
      'BteamName': ' BteamName',
      'date': 'date',
      'location': '지역'
    },
    {
      'AteamLogo': 'Ateamlogo',
      'BteamLogo': 'BteamLogo',
      'AteamName': 'AteamName',
      'BteamName': ' BteamName',
      'date': 'date',
      'location': '지역'
    },
    {
      'AteamLogo': 'Ateamlogo',
      'BteamLogo': 'BteamLogo',
      'AteamName': 'AteamName',
      'BteamName': ' BteamName',
      'date': 'date',
      'location': '지역'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 28,
          ),
          Row(
            children: [
              SizedBox(
                width: 10,
              ),
              Text(
                '경기 일정',
                style: TextStyle(
                  fontSize: 24,
                  color: Color.fromARGB(255, 245, 245, 245),
                  fontWeight: FontWeight.w600,
                ),
              )
            ],
          ),
          Column(
            children: _items
                .map((item) => EsportsCard(
                      AteamLogo: item['AteamLogo']!,
                      BteamLogo: item['BteamLogo']!,
                      AteamName: item['AteamName']!,
                      BteamName: item['BteamLogo']!,
                      date: item['date']!,
                      location: item['location']!,
                    ))
                .toList(),
          ),
        ],
      ),
    );
  }
}