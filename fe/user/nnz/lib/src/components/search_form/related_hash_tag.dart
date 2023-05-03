import 'package:flutter/material.dart';

import '../../config/config.dart';

class RelatedHashTag extends StatelessWidget {
  const RelatedHashTag({super.key});

  @override
  Widget build(BuildContext context) {
    final tagList = ['square', '포카', '다꾸', '응원봉', '싱어송라이터'];
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 8,
      ),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            "이런 검색은 어떠세요?",
            style: TextStyle(
              fontSize: 16,
              color: Config.blackColor,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Wrap(
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
              ))
        ],
      ),
    );
  }
}
