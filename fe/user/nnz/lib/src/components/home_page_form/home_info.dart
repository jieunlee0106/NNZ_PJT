import 'package:flutter/material.dart';
import 'package:nnz/src/components/icon_data.dart';
import 'package:nnz/src/components/sharing_detail/test_infinite.dart';

class HomeInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: 10,
      ),
      height: 200,
      width: 500,
      color: Color.fromARGB(255, 237, 237, 237),
      child: Expanded(
        child: Padding(
          padding: const EdgeInsets.only(
            top: 40,
            bottom: 20,
          ),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  '나너주유',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  '개인 정보 처리 방침',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text('개발: 김종성, 김지환, 염유리, 유영훈, 이지은,  하세진'),
                Text('위치: 대전광역시 유성구'),
              ]),
        ),
      ),
    );
  }
}
