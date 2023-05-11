import 'package:flutter/material.dart';
import 'package:nnz/src/config/config.dart';

class ShareCard extends StatelessWidget {
  const ShareCard({super.key, required this.title, required this.opentime});

  final String title;
  final DateTime opentime;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
                blurRadius: 5.0,
                offset: const Offset(0.7, 0.7),
                color: Colors.grey.withOpacity(0.5)),
          ]),
      child: Column(
        children: [
          Image.asset(
            "assets/images/sharing_sample/sharingsource.jpg",
            height: 110,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            title,
            style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: Config.blackColor),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: Text(
              opentime.toString(),
              style: const TextStyle(
                fontSize: 12,
                color: Color(0xFF585858),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
