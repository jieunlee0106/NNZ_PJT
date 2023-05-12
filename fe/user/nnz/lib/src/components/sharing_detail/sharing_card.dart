import 'package:flutter/material.dart';

class SharingDetailCard extends StatelessWidget {
  final String performTitle;
  final String openDate;
  final String condition;

  const SharingDetailCard(
      {super.key,
      required this.performTitle,
      required this.openDate,
      required this.condition});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: Container(
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 239, 236, 236),
          borderRadius: BorderRadius.circular(5),
          boxShadow: [
            BoxShadow(
                blurRadius: 5.0,
                offset: const Offset(0.7, 0.7),
                color: Colors.grey.withOpacity(0.7)),
          ],
        ),
        child: Row(
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 13),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "나눔 공연",
                    style: TextStyle(
                      fontSize: 13,
                      color: Color(0xFF525252),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    "오픈 날짜",
                    style: TextStyle(
                      fontSize: 13,
                      color: Color(0xFF525252),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    "인증 조건",
                    style: TextStyle(
                      fontSize: 13,
                      color: Color(0xFF525252),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    performTitle,
                    style: const TextStyle(
                      fontSize: 13,
                      color: Color(0xFF0d0d0d),
                    ),
                  ),
                  const SizedBox(
                    height: 9,
                  ),
                  Text(
                    openDate,
                    style: const TextStyle(
                      fontSize: 13,
                      color: Color(0xFF0d0d0d),
                    ),
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  Text(
                    condition,
                    style: const TextStyle(
                      fontSize: 13,
                      color: Color(0xFF0d0d0d),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
