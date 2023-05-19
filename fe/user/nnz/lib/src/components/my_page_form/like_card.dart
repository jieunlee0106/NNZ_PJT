import 'package:flutter/material.dart';
import 'package:nnz/src/components/icon_data.dart';
import 'package:nnz/src/config/config.dart';
import 'package:marquee/marquee.dart';
import 'package:get/get.dart';
import 'package:nnz/src/controller/likes_controller.dart';
import 'package:nnz/src/pages/share/my_shared_detail.dart';
import 'package:nnz/src/pages/share/share_detail.dart';

class LikeCard extends StatefulWidget {
  final String image;
  final String title;
  final String subtitle;
  final String location;
  final int status;
  final int nanumId;

  LikeCard({
    required this.image,
    required this.title,
    required this.subtitle,
    required this.location,
    required this.status,
    required this.nanumId,
  });
  @override
  _LikeCardState createState() => _LikeCardState();
}

class _LikeCardState extends State<LikeCard> {
  final controller = Get.put(LikesController());

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Stack(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      ShareDatail(nanumIds: widget.nanumId ?? 0),
                ),
              );
            },
            child: Container(
              width: 110,
              height: 160,
              margin: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.7),
                    spreadRadius: 1,
                    blurRadius: 3,
                    offset: Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 110,
                    height: 90,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 255, 253, 253),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(8),
                        topRight: Radius.circular(8),
                      ),
                      image: DecorationImage(
                        image: NetworkImage(widget.image),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5, left: 5),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 150, // set a width for the Text widget
                          child: Text(
                            widget.subtitle,
                            style: TextStyle(
                              color: Color.fromARGB(255, 11, 40, 126),
                              fontSize: 10,
                              fontWeight: FontWeight.w700,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        SizedBox(
                          width: 150, // set a width for the Text widget
                          child: Text(
                            widget.title,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w900,
                              overflow: TextOverflow.ellipsis,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        SizedBox(
                          width: 150, // set a width for the Text widget
                          child: Text(
                            widget.location,
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w400,
                              overflow: TextOverflow.ellipsis,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (widget.status == 3) // 나눔 종료 3으로 수정
            Positioned.fill(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text('관심 나눔 삭제'),
                            content: Text('관심 나눔 목록에서 삭제하시겠습니까?'),
                            actions: <Widget>[
                              TextButton(
                                  onPressed: () async {
                                    await controller.deleteLikesList(
                                        nanumId: widget.nanumId);
                                    // 좋아요 취소 & 목록 조회 요청
                                    Get.offNamed('/likes');
                                  },
                                  child: Text(
                                    '네,삭제할게요',
                                    style:
                                        TextStyle(fontWeight: FontWeight.w600),
                                  )),
                              TextButton(
                                onPressed: () {
                                  Get.to(() => MyShareDetail(
                                        nanumIds: widget.nanumId ?? 0,
                                      ));
                                },
                                child: Text(
                                  '아니요, 나눔 볼러갈래요   ',
                                  style: TextStyle(fontWeight: FontWeight.w600),
                                ),
                              )
                            ],
                          );
                        });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.6),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(
                          child: Text(
                            '종료된 나눔 입니다',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Icon(
                          Icons.delete,
                          color: Colors.white,
                          size: 24,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
