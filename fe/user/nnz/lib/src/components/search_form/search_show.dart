import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nnz/src/controller/search_controller.dart';
import 'package:nnz/src/model/searh_nanum_list_model.dart';

import '../../config/config.dart';
import '../icon_data.dart';

class SearchShow extends StatelessWidget {
  SearchShow({super.key});
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
          return SizedBox(
            height: Get.width * 0.8,
            child: ListView.builder(
              physics: const AlwaysScrollableScrollPhysics(),
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: controller.nanumList.length,
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
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 200,
                          child: Image.network(
                            controller.nanumList[index].thumbnail!,
                            width: 200,
                          ),
                        ),
                        const SizedBox(
                          width: 18,
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ),
          );
        }
      },
    );
  }
}
