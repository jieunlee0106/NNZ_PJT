import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:nnz/src/controller/sharing_register_controller.dart';

class SportsCategory extends StatefulWidget {
  const SportsCategory({super.key, this.childCategoriesList});
  final childCategoriesList;
  @override
  State<SportsCategory> createState() => _SportsCategoryState();
}

class _SportsCategoryState extends State<SportsCategory> {
  List<String> _sportsItems = [];
  String? _selectedSports;
  final controller = Get.put(SharingRegisterController());
  final logger = Logger();
  List<dynamic> showList = [];
  @override
  void initState() {
    super.initState();
    _sportsItems = widget.childCategoriesList;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 16,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 4,
          ),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xffF3F3F3),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: DropdownButton<String>(
                  underline: Container(),
                  isDense: true,
                  padding: const EdgeInsetsDirectional.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  icon: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: Get.width * 0.1,
                    ),
                    child: const Icon(
                      Icons.keyboard_arrow_down,
                    ),
                  ),
                  hint: const Text(
                    "카테고리 선택해주세요",
                  ),
                  value: _selectedSports,
                  onChanged: (newValue) {
                    setState(() {
                      _selectedSports = newValue;
                    });
                  },
                  items: _sportsItems.map((item) {
                    return DropdownMenuItem(
                      value: item,
                      child: Text(item),
                    );
                  }).toList(),
                ),
              ),
              _selectedSports != null
                  ? Column(
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        //검색을 하는 api가 있어야 됨
                        TextField(
                          decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.search),
                          ),
                          controller: controller.nempSearchController,
                          onChanged: (value) async {
                            logger.i(controller.nempSearchController.text);
                            showList = await controller.onSearchShow(
                                category: _selectedSports!,
                                title: controller.nempSearchController.text);
                            logger.i("과연 $showList");
                          },
                        ),
                        FutureBuilder<List>(
                          future: controller.onSearchShow(
                              category: _selectedSports!,
                              title: controller.nempSearchController.text),
                          builder: (BuildContext context,
                              AsyncSnapshot<List> snapshot) {
                            if (snapshot.hasData) {
                              return ListView.builder(
                                itemCount: snapshot.data!.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return ListTile(
                                    title: Text(snapshot.data![index].title),
                                    subtitle:
                                        Text(snapshot.data![index].subtitle),
                                  );
                                },
                              );
                            } else if (snapshot.hasError) {
                              return Text('Error: ${snapshot.error}');
                            } else {
                              return const Center(
                                  child: CircularProgressIndicator());
                            }
                          },
                        ),
                        // if (showList.isEmpty) ...[
                        //   Flexible(
                        //     flex: 3,
                        //     child: ListView.builder(
                        //         scrollDirection: Axis.vertical,
                        //         itemCount: showList.length,
                        //         itemBuilder: (BuildContext context, int index) {
                        //           return SizedBox(
                        //             height: 50,
                        //             child: Text("${showList[index]["title"]}"),
                        //           );
                        //         }),
                        //   )
                        // ],
                        // if (showList.isNotEmpty) ...[
                        //   Expanded(
                        //     child: ListView.builder(
                        //         scrollDirection: Axis.vertical,
                        //         itemCount: showList.length,
                        //         itemBuilder: (BuildContext context, int index) {
                        //           return Text("${showList[index]["title"]}");
                        //         }),
                        //   )
                        // ]
                      ],
                    )
                  : Container(),
            ],
          ),
        ),
      ],
    );
  }
}
