import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nnz/src/config/config.dart';

class HomeShareText extends StatelessWidget {
  final String text;
  final String image;
  final String smallText;
  final String plus;
  final Widget page;

  const HomeShareText({
    super.key,
    required this.text,
    required this.image,
    required this.smallText,
    required this.plus,
    required this.page,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 10,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Image(
                          image: AssetImage(image),
                          width: 35,
                          height: 35,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          text,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: Config.blackColor,
                            fontSize: 18,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: () async {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => page),
                        );
                      },
                      child: Text(
                        plus,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(smallText)
              ],
            ),
          ),
        ],
      ),
    );
  }
}
