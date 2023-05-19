import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nnz/src/components/category/show_null_page.dart';
import 'package:nnz/src/controller/tag_controller.dart';
import 'package:nnz/src/model/nanum_tag.dart';
import 'package:nnz/src/model/show_tag.dart';
import 'package:nnz/src/pages/share/sharing_perform.dart';

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
  bool _isLoading = true;

  Future<void> getSList() async {
    await controller.getShowTag(widget.tagName);
    showTag = controller.showTag;
    print('태그 쇼 리스트 받아와짐');
    items = showTag.content;
    print(items);
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();

    getSList();
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    if (items.length == 0)
      return Center(
        child: NullPage3(message: '공연 목록이 존재하지 않습니다'),
      );

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: items
            .map(
              (item) => GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          SharePerformDetail(showIds: item.id),
                    ),
                  );
                },
                child: Container(
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
                            image: NetworkImage(item.poster),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
