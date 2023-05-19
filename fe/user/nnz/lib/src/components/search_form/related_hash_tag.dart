import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nnz/src/controller/search_controller.dart';
import 'package:nnz/src/model/tag_list_model.dart';

import '../../config/config.dart';

class RelatedHashTag extends StatelessWidget {
  RelatedHashTag({super.key});
  final controller = Get.put(ShowSearchController());
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<TagListModel>>(
        future:
            controller.onRelatedSearch(text: controller.searchController.text),
        builder:
            (BuildContext context, AsyncSnapshot<List<TagListModel>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text("Error : ${snapshot.hasError}");
          } else if (snapshot.data!.isEmpty) {
            return Container();
          } else {
            List<String> tagList = [];
            for (var data in snapshot.data!) {
              tagList.add(data.tag!);
            }
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
                        controller.relatedTagList.length,
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
                                    color: const Color(0xff000000)
                                        .withOpacity(0.25),
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
        });
  }
}
