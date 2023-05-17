import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nnz/src/components/category/show_null_page.dart';
import 'package:nnz/src/components/tag/tag_card.dart';
import 'package:nnz/src/controller/tag_controller.dart';
import 'package:nnz/src/model/nanum_tag.dart';
import 'package:nnz/src/model/show_tag.dart';

class TagNanumList extends StatefulWidget {
  final String tagName;

  const TagNanumList({
    Key? key,
    required this.tagName,
  }) : super(key: key);

  @override
  _TagNanumListState createState() => _TagNanumListState();
}

class _TagNanumListState extends State<TagNanumList> {
  final controller = Get.put(TagController());

  late NanumTag nanumTag;
  late List<Content2> items1; // 나눔

  bool _isLoading = true;

  Future<void> getNList() async {
    await controller.getNanumTag(widget.tagName);
    nanumTag = controller.nanumTag;
    items1 = nanumTag.content;
    print('asdasdasd');
    print(items1);
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    getNList();
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    if (items1.length == 0)
      return Center(
        child: NullPage3(message: '나눔 목록이 존재하지 않습니다'),
      );

    return GridView.count(
      shrinkWrap: true,
      crossAxisCount: 2,
      mainAxisSpacing: 16,
      crossAxisSpacing: 16,
      childAspectRatio: 0.75,
      children: items1
          .map(
            (item) => TagCard(
              thumbnail: item.poster ?? '',
              title: item.title ?? '',
              id: item.id ?? 0,
            ),
          )
          .toList(),
    );
  }
}
