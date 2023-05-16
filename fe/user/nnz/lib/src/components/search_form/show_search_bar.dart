import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:nnz/src/config/config.dart';
import 'package:nnz/src/controller/search_controller.dart';

class ShowSearchBar extends StatefulWidget {
  const ShowSearchBar({Key? key}) : super(key: key);

  @override
  State<ShowSearchBar> createState() => _ShowSearchBarState();
}

class _ShowSearchBarState extends State<ShowSearchBar> {
  final controller = Get.put(ShowSearchController());
  final logger = Logger();
  final List<String> _selectList = ['공연', '나눔'];
  String _selectItem = '공연';
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: Config.blackColor,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 8,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              DropdownButton<String>(
                  value: _selectItem,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                  ),
                  icon: const Icon(Icons.keyboard_arrow_down),
                  underline: Container(),
                  items: _selectList.map((item) {
                    return DropdownMenuItem(
                      value: item,
                      child: Center(
                        child: Text(item),
                      ),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectItem = value!;
                    });
                    controller.type(value);
                    logger.i("타입 바뀌어줘 ${controller.type.value}");
                  }),
              Expanded(
                child: TextField(
                  controller: controller.searchController,
                  onChanged: (text) {
                    controller.searchText.value = text;
                    if (_selectItem == '공연') {
                      logger.i("서버야 공연 불러와줘");
                    } else if (_selectItem == '나눔') {
                      logger.i("서버야 나눔 불러와줘");
                      controller.getNanumList(
                          q: controller.searchController.text);
                    }
                  },
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: _selectItem == '공연'
                        ? "찾고 있는 공연이 있으신가요?"
                        : "찾고 있는 나눔이 있으신가요?",
                    suffixIcon: const Icon(
                      Icons.search_rounded,
                      color: Color(0xff898787),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
