import 'package:flutter/material.dart';
import 'package:nnz/src/config/config.dart';

class PopularHashTag extends StatelessWidget {
  const PopularHashTag({super.key});

  @override
  Widget build(BuildContext context) {
    final tagList = ['스티커', 'nct', '다꾸', '응원봉', '트와이스', '전종서', '뉴진스', '종이의집'];
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            "인기 해시태그",
            style: TextStyle(
              fontSize: 16,
              color: Config.blackColor,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 8,
            ),
            child: Wrap(
                spacing: 10,
                runSpacing: 10,
                children: List.generate(
                  tagList.length,
                  (index) => SizedBox(
                    height: 32,
                    child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 4,
                              offset: const Offset(0, 4),
                              color: const Color(0xff000000).withOpacity(0.25),
                            )
                          ],
                          color: Config.rigthYellowColor,
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(tagList[index]),
                          ],
                        )),
                  ),
                )),
          )
        ],
      ),
    );
  }
}
