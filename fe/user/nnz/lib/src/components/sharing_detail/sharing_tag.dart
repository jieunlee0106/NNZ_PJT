import 'package:flutter/material.dart';
import 'package:nnz/src/config/config.dart';

class HashTagBadge extends StatelessWidget {
  const HashTagBadge({super.key, required this.tags});

  final List<dynamic> tags;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: tags.map((entry) {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            margin: const EdgeInsets.only(right: 8),
            decoration: BoxDecoration(
              color: const Color(0xFFF3C906),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              "${entry["tagName"]}",
              style: TextStyle(
                color: Config.blackColor,
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
