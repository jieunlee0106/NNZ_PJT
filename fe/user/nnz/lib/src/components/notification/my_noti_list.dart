import 'package:flutter/material.dart';

class MyNotiList extends StatelessWidget {
  MyNotiList({Key? key}) : super(key: key);

  final List<Map<String, String>> _items = [
    {
      'title': '트와이스 둘째날 키링 나눔',
      'date': '2023.03.10',
    },
    {
      'title': 'Nell 포카 나눔',
      'date': '2023.03.10',
    },
    {
      'title': 'BTS 포카 나눔',
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
                title: Text(item['title']! + '이 오픈 되었습니다.'),
                subtitle: Text(item['date']!),
              ))
          .toList(),
    );
  }
}
