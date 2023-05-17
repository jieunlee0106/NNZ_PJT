import 'package:flutter/material.dart';
import 'package:nnz/src/components/icon_data.dart';

class Event extends StatelessWidget {
  final String image;
  final int num;

  Event({
    Key? key,
    required this.image,
    required this.num,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 340,
          height: 90,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(7.0),
            image: DecorationImage(
              image: AssetImage(ImagePath.event),
              fit: BoxFit
                  .cover, // Set the fit property to cover the container size
              alignment: Alignment.topCenter,
            ),
          ),
        ),
      ],
    );
  }
}
