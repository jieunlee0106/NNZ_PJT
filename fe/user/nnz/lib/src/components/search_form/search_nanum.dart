import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:nnz/src/config/token.dart';
import 'package:nnz/src/controller/search_controller.dart';
import 'package:nnz/src/model/searh_nanum_list_model.dart';

import '../../config/config.dart';
import '../../pages/search/tag_page.dart';
import '../../pages/share/share_detail.dart';
import '../icon_data.dart';

class SearchNanum extends StatelessWidget {
  SearchNanum({super.key});
  final controller = Get.put(ShowSearchController());
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Content>>(
      future: controller.getNanumList(q: controller.searchController.text),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text("Error : ${snapshot.hasError}");
        } else if (controller.nanumList.isEmpty) {
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
                                    GestureDetector(
                                        onTap: () {
                                          Get.to(() => TagPage(
                                                tagName:
                                                    controller.rTagList[index],
                                              ));
                                        },
                                        child:
                                            Text(controller.rTagList[index])),
                                  ],
                                )),
                          ),
                        ))
                  ],
                ),
              ),
              SizedBox(
                height: Get.width,
                child: ListView.builder(
                  physics: const AlwaysScrollableScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: controller.nanumList.length,
                  itemBuilder: ((context, index) {
                    return GestureDetector(
                      onTap: () async {
                        Logger().i(controller.nanumList[index].id);
                        final token = await Token.getAccessToken();
                        Logger().i(token);
                        if (token == null) {
                          Get.toNamed("/register");
                        } else {
                          Get.to(() => ShareDatail(
                                nanumIds: controller.nanumList[index].id!,
                              ));
                        }
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(
                          vertical: 8,
                        ),
                        padding: const EdgeInsets.symmetric(
                          vertical: 12,
                          horizontal: 20,
                        ),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                offset: const Offset(0, 4),
                                blurRadius: 4,
                                color: Colors.transparent.withOpacity(0.5),
                              )
                            ]),
                        child: Row(
                          children: [
                            Expanded(
                              child: Image.network(
                                "${controller.nanumList[index].thumbnail}",
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      controller.nanumList[index].title!,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    Text(
                                      "나눔 일시",
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Config.blackColor,
                                      ),
                                    ),
                                    Text(
                                      controller.nanumList[index].nanumDate
                                          .toString()
                                          .substring(0, 10),
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: Config.blackColor),
                                    ),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    Text(
                                      "공연제목",
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Config.blackColor,
                                      ),
                                    ),
                                    Text(
                                      "${controller.nanumList[index].show!.title}",
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Config.blackColor,
                                      ),
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
                                      "${controller.nanumList[index].show!.location}",
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
                                        controller
                                            .nanumList[index].tags!.length,
                                        (i) => Container(
                                          height: 32,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(16),
                                            color: Config.yellowColor,
                                          ),
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 8,
                                            vertical: 4,
                                          ),
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Text(
                                                "#${controller.nanumList[index].tags![i].tag}",
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500,
                                                  color: Config.blackColor,
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
