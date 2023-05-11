import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nnz/src/components/my_page_form/like_card.dart';
import 'package:nnz/src/controller/likes_controller.dart';
import 'package:nnz/src/model/likes_model.dart';

class LikesList extends StatefulWidget {
  const LikesList({
    Key? key,
  }) : super(key: key);

  @override
  _LikesListState createState() => _LikesListState();
}

class _LikesListState extends State<LikesList> {
  final controller = Get.put(LikesController());

  late Likes likes;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    getList();
  }

  Future<void> getList() async {
    await controller.getLikesList();
    likes = controller.likes;
    print(likes);
    setState(() {
      likes = controller.likes;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }

    return GridView.count(
      shrinkWrap: true,
      crossAxisCount: 2,
      mainAxisSpacing: 16,
      crossAxisSpacing: 16,
      childAspectRatio: 0.75,
      // children: likes
      //     .map(
      //       (item) => LikeCard(
      //         image: item,
      //         title: item['title']!,
      //         subtitle: item['subtitle']!,
      //         location: item['location']!,
      //       ),
      //     )
      //     .toList(),
    );
  }
}
