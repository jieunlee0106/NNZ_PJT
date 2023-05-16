import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nnz/src/controller/tag_controller.dart';
import 'package:nnz/src/model/nanum_tag.dart';
import 'package:nnz/src/model/show_tag.dart';

class TagShow extends StatefulWidget {
  final String tagName;

  const TagShow({
    Key? key,
    required this.tagName,
  }) : super(key: key);

  @override
  _TagShowState createState() => _TagShowState();
}

class _TagShowState extends State<TagShow> {
  final controller = Get.put(TagController());

  late ShowTag showTag;
  late List<Content> items;

  Future<void> getSList() async {
    await controller.getShowTag(widget.tagName);
    showTag = controller.showTag;
    items = showTag.content;
    print(items);
  }

  @override
  void initState() {
    super.initState();

    getSList();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: items
            .map(
              (item) => Container(
                width: 110,
                height: 160,
                margin: const EdgeInsets.all(8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 110,
                      height: 160,
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 255, 253, 253),
                        borderRadius: BorderRadius.circular(4.0),
                        image: DecorationImage(
                          image: NetworkImage(item.thumbnail),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
