import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:nnz/src/model/popular_tag_model.dart';

import '../../config/config.dart';
import '../../controller/search_controller.dart';

class PopularHashTag extends StatelessWidget {
  const PopularHashTag({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ShowSearchController());
    return FutureBuilder<List<PopularTagModel>>(
      future: controller.onPopularTag(),
      builder: (BuildContext context,
          AsyncSnapshot<List<PopularTagModel>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          //API 응답이 오기 전에는 로딩 중을 표시
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text("Error : ${snapshot.error}");
        } else if (!snapshot.hasData) {
          return const Text("No Data");
        }
        List<String> itemList = [];
        List<String> hashtagList = [];
        for (var data in snapshot.data!) {
          itemList.add(data.tag);
        }
        for (var item in itemList) {
          RegExp exp = RegExp(r'\#\w+');
          Iterable<Match> matches = exp.allMatches(item);
          for (Match match in matches) {
            hashtagList.add(match.group(0)!);
          }
        }
        Logger().i("들어왔지? $itemList");
        Logger().i("그럼 너는? ${itemList.length}");
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
                      itemList.length,
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
                                  color:
                                      const Color(0xff000000).withOpacity(0.25),
                                )
                              ],
                              color: Config.rigthYellowColor,
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(itemList[index]),
                              ],
                            )),
                      ),
                    )),
              )
            ],
          ),
        );
      },
    );
  }
}
