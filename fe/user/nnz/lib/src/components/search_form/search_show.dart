import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nnz/src/components/search_form/no_result_search.dart';
import 'package:nnz/src/controller/search_controller.dart';
import 'package:nnz/src/model/search_show_list_model.dart';

import '../../config/config.dart';

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
          return NoResultSearch();
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
                          controller.rTagList.length,
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
                              ),
                            ),
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
                            ? GestureDetector(
                                onTap: () {},
                                child: Container(
                                  margin: const EdgeInsets.symmetric(
                                    vertical: 8,
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 12,
                                    horizontal: 20,
                                  ),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Image.network(
                                          "${controller.showList[index].poster}",
                                          width: 120,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 20,
                                      ),
                                      Expanded(
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                            // horizontal: 14,
                                            vertical: 8,
                                          ),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                controller
                                                    .showList[index].title!,
                                                style: const TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 8,
                                              ),
                                              Text(
                                                "공연 일시",
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  color: Config.blackColor,
                                                ),
                                              ),
                                              Text(
                                                controller
                                                    .showList[index].startDate
                                                    .toString()
                                                    .substring(0, 10),
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    color: Config.blackColor),
                                              ),
                                              const SizedBox(
                                                height: 8,
                                              ),
                                              const SizedBox(
                                                height: 8,
                                              ),
                                              Text(
                                                "공연장소",
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  color: Config.blackColor,
                                                ),
                                              ),
                                              Text(
                                                "${controller.showList[index].location}",
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  color: Config.blackColor,
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 8,
                                              ),
                                              Wrap(
                                                spacing: 8,
                                                runSpacing: 8,
                                                children: List.generate(
                                                  controller.showList[index]
                                                      .tags!.length,
                                                  (i) => Container(
                                                    height: 32,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              16),
                                                      color: Config.yellowColor,
                                                    ),
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                      horizontal: 8,
                                                      vertical: 4,
                                                    ),
                                                    child: Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: [
                                                        Text(
                                                          "#${controller.showList[index].tags![i].tag}",
                                                          style: TextStyle(
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            color: Config
                                                                .blackColor,
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                            width: 4),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            : Column(
                                children: [
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
                                          const SizedBox(
                                            height: 8,
                                          ),
                                          Wrap(
                                            spacing: 8,
                                            runSpacing: 8,
                                            children: List.generate(
                                              controller
                                                  .showList[index].tags!.length,
                                              (i) => Container(
                                                height: 32,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(16),
                                                  color: Config.yellowColor,
                                                ),
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                  horizontal: 8,
                                                  vertical: 4,
                                                ),
                                                child: Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    Text(
                                                      "#${controller.showList[index].tags![i].tag}",
                                                      style: TextStyle(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color:
                                                            Config.blackColor,
                                                      ),
                                                    ),
                                                    const SizedBox(width: 4),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                      ),
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
