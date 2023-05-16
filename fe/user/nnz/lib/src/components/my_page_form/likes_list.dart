import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nnz/src/components/my_page_form/like_card.dart';
import 'package:nnz/src/controller/likes_controller.dart';
import 'package:nnz/src/model/likes_model.dart';

class LikesList extends StatefulWidget {
  final List<Likes> items;

  const LikesList({
    Key? key,
    required this.items,
  }) : super(key: key);

  @override
  _LikesListState createState() => _LikesListState();
}

class _LikesListState extends State<LikesList> {
  final controller = Get.put(LikesController());

  late List<Likes> likes;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    getList();
  }

  Future<void> getList() async {
    await controller.getLikesList();
    likes = controller.likesList;
    print(likes.runtimeType);

    // print(likes.id);
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      crossAxisCount: 3,
      mainAxisSpacing: 10,
      crossAxisSpacing: 1,
      childAspectRatio: 0.75,
      children: widget.items
          .map(
            (item) => LikeCard(
              image: item.thumbnail!,
              title: item.title!,
              subtitle: item.show?.title ?? '',
              location: item.show?.location ?? '장소 미정',
              status: item.status ?? 0,
              nanumId: item.id ?? 0,
            ),
          )
          .toList(),
    );
  }
}
