import 'package:flutter/material.dart';
import 'package:nnz/src/components/icon_data.dart';
import 'package:carousel_slider/carousel_slider.dart';

class CarouselWithIndicator2 extends StatefulWidget {
  @override
  _CarouselWithIndicatorState2 createState() => _CarouselWithIndicatorState2();
}

class _CarouselWithIndicatorState2 extends State<CarouselWithIndicator2> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('sadasd'),
        Container(
          width: 340,
          margin: EdgeInsets.symmetric(horizontal: 10.0),
          decoration: BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.circular(10),
            image: DecorationImage(
              image: AssetImage('assets/images/match.jpg'),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ],
    );
  }
}
