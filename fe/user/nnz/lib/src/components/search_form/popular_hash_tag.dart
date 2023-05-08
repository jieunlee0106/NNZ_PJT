import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nnz/src/config/config.dart';

import '../../controller/search_controller.dart';

class PopularHashTag extends StatelessWidget {
  const PopularHashTag({super.key});

  @override
  Widget build(BuildContext context) {
    final tagList = ['스티커', 'nct', '다꾸', '응원봉', '트와이스', '전종서', '뉴진스', '종이의집'];
    final controller = Get.put(ShowSearchController());
    // return FutureBuilder<List<String>>(
    //     future: controller.onPopularTag(),
    //     builder: (BuildContext context, AsyncSnapshot<List<String>> snapshot) {
    //       if (snapshot.connectionState == ConnectionState.waiting) {
    //         //API 응답이 오기 전에는 로딩 중을 표시
    //         return CircularProgressIndicator();
    //       } else if (snapshot.hasError) {
    //         return Text("Error : ${snapshot.error}");
    //       } else if (!snapshot.hasData) {
    //         return Text("No Data");
    //       } else {
    //         List<String> itemList = snapshot.data!;
    //         List<String> hashtagList = [];
    //         for (var item in itemList) {
    //           RegExp exp = RegExp(r'\#\w+');
    //           Iterable<Match> matches = exp.allMatches(item);
    //           for (Match match in matches) {
    //             hashtagList.add(match.group(0)!);
    //           }
    //         }
    //         return ListView.builder(
    //             itemCount: hashtagList.length,
    //             itemBuilder: (BuildContext context, int index) {
    //               return ListTile(
    //                 title: Text(hashtagList[index]),
    //               );
    //             });
    //       }
    //     });

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
