import 'package:flutter/material.dart';
import 'package:nnz/src/components/icon_data.dart';
import 'package:nnz/src/config/config.dart';
import 'package:marquee/marquee.dart';

class TagCard extends StatelessWidget {
  final String thumbnail;
  final String title;
  final int id;

  TagCard({
    required this.thumbnail,
    required this.title,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      height: 200,
      margin: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 150,
            height: 130,
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 255, 253, 253),
              borderRadius: BorderRadius.circular(8.0),
              image: DecorationImage(
                image: NetworkImage(thumbnail),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 5, left: 5),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: Color.fromARGB(255, 11, 40, 126),
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 3),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w900,
                    overflow: TextOverflow.ellipsis,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 3),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
