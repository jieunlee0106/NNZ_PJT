import 'package:flutter/material.dart';
import 'package:nnz/src/components/icon_data.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:nnz/src/pages/share/my_shared_detail.dart';
import 'package:nnz/src/pages/share/sharing_perform.dart';

class CarouselWithIndicator2 extends StatefulWidget {
  @override
  _CarouselWithIndicatorState2 createState() => _CarouselWithIndicatorState2();
}

class _CarouselWithIndicatorState2 extends State<CarouselWithIndicator2> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => SharePerformDetail(showIds: 4573)),
        );
      },
      child: Column(
        children: [
          Container(
            width: 350,
            height: 90,
            margin: EdgeInsets.symmetric(horizontal: 10.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                image: AssetImage('assets/images/match.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
