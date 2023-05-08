import 'package:flutter/material.dart';
import 'package:nnz/src/components/icon_data.dart';
import 'package:nnz/src/config/config.dart';
import 'package:marquee/marquee.dart';
import 'package:nnz/src/components/category/show_card.dart';

class SiteNotiList extends StatelessWidget {
  SiteNotiList({Key? key}) : super(key: key);

  final List<Map<String, String>> _items = [
    {
      'title': '05.09.화 20:00 ~ 22:00 서버 점검',
      'date': '2023.03.10',
    },
    {
      'title': 'Nell 포카 나눔',
      'date': '2023.03.10',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: _items
          .map((item) => ListTile(
                leading: Icon(
                  Icons.alarm,
                ),
                title: Text(item['title']!),
                subtitle: Text(item['date']!),
              ))
          .toList(),
    );
  }
}
