import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nnz/src/config/config.dart';
import 'package:marquee/marquee.dart';
import 'package:nnz/src/config/token.dart';
import 'package:nnz/src/controller/bottom_nav_controller.dart';
import 'package:nnz/src/model/popularity.dart';
import 'package:nnz/src/pages/share/share_detail.dart';
import 'package:nnz/src/pages/user/register.dart';

class HomeShareList extends StatefulWidget {
  final List<PopularityList> items;

  const HomeShareList({
    Key? key,
    required this.items,
  }) : super(key: key);

  @override
  _HomeShareListState createState() => _HomeShareListState();
}

class _HomeShareListState extends State<HomeShareList> {
  String? token;

  void initState() {
    super.initState();
    tokenData();
  }

  void tokenData() async {
    token = await Token.getAccessToken();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: widget.items
            .map(
              (item) => GestureDetector(
                onTap: () async {
                  if (token != null) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            ShareDatail(nanumIds: item.id ?? 0),
                      ),
                    );
                  } else {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Register(),
                      ),
                    );
                  }
                },
                child: Container(
                  width: 150,
                  height: 200,
                  margin: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 150,
                        height: 130,
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 255, 253, 253),
                          borderRadius: BorderRadius.circular(8.0),
                          image: DecorationImage(
                            image: NetworkImage(item.thumbnail ?? ''),
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
                            Text(
                              item.show?.title ?? '공연 제목입니다',
                              style: TextStyle(
                                color: Color.fromARGB(255, 11, 40, 126),
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(height: 3),
                            Text(
                              item.title!,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w900,
                                overflow: TextOverflow.ellipsis,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(height: 3),
                            Text(
                              item.show?.location ?? '장소 미정',
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w400,
                                overflow: TextOverflow.ellipsis,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
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
