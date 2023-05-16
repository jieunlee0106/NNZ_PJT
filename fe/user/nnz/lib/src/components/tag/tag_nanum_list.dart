import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
  late List<Content1> items1; // 나눔

  Future<void> getNList() async {
    await controller.getNanumTag(widget.tagName);
    nanumTag = controller.nanumTag;
    items1 = nanumTag.content;
    print(items1);
  }

  @override
  void initState() {
    super.initState();
    getNList();
  }

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      crossAxisCount: 2,
      mainAxisSpacing: 16,
      crossAxisSpacing: 16,
      childAspectRatio: 0.75,
      children: items1
          .map(
            (item) => TagCard(
              thumbnail: item.thumbnail ?? '',
              title: item.title ?? '',
              location: item.location ?? '장소 미정',
            ),
          )
          .toList(),
    );
  }
}
