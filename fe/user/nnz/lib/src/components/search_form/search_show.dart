import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nnz/src/controller/search_controller.dart';
import 'package:nnz/src/model/search_show_list_model.dart';

import '../../config/config.dart';
import '../icon_data.dart';

class SearchShow extends StatelessWidget {
  SearchShow({super.key});
  final controller = Get.put(ShowSearchController());
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Content>>(
      future: controller.getShowList(q: controller.searchController.text),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text("Error : ${snapshot.hasError}");
        } else if (controller.showList.isEmpty) {
          return Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    iconData(
                      icon: ImagePath.sad,
                      size: 240,
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    Text(
                      "검색 결과가 없습니다.",
                      style: TextStyle(
                        fontSize: 16,
                        color: Config.blackColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        } else {
          return Column(
            children: [
              Container(
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
                                    Text(controller.rTagList[index]),
                                  ],
                                )),
                          ),
                        ))
                  ],
                ),
              ),
              SizedBox(
                height: Get.width * 0.8,
                child: ListView.builder(
                  physics: const AlwaysScrollableScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: controller.showList.length,
                  itemBuilder: ((context, index) {
                    return Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 10,
                      ),
                      child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  offset: const Offset(0, 4),
                                  blurRadius: 4,
                                  color: Colors.black.withOpacity(0.25),
                                )
                              ]),
                          child: controller.showList[index].poster != null
                              ? Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: 200,
                                      child: Image.network(
                                        controller.showList[index].poster!,
                                        width: 200,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 18,
                                    ),
                                  ],
                                )
                              : Column(children: [
                                  GestureDetector(
                                    onTap: () {},
                                    child: Container(
                                      margin: const EdgeInsets.symmetric(
                                        vertical: 8,
                                      ),
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 12,
                                        horizontal: 16,
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            controller.showList[index].title!,
                                            style: TextStyle(
                                              color: Config.blackColor,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          Text(
                                            controller
                                                .showList[index].startDate!,
                                            style: TextStyle(
                                              color: Config.blackColor,
                                              fontSize: 14,
                                            ),
                                          ),
                                          controller.showList[index].location ==
                                                  null
                                              ? Container()
                                              : Text(
                                                  controller
                                                      .showList[index].location,
                                                  style: TextStyle(
                                                    color: Config.blackColor,
                                                    fontSize: 14,
                                                  ),
                                                ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ])),
                    );
                  }),
                ),
              ),
            ],
          );
        }
      },
    );
  }
}
