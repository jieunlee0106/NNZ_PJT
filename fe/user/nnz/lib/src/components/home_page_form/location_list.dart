import 'package:flutter/material.dart';
import 'package:nnz/src/config/config.dart';
import 'package:marquee/marquee.dart';
import 'package:nnz/src/config/token.dart';
import 'package:nnz/src/model/location_model.dart';
import 'package:nnz/src/model/popularity.dart';

class HomeShareList2 extends StatefulWidget {
  final List<Content> items;

  const HomeShareList2({
    Key? key,
    required this.items,
  }) : super(key: key);

  @override
  _HomeShareListState createState() => _HomeShareListState();
}

class _HomeShareListState extends State<HomeShareList2> {
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
        mainAxisAlignment: MainAxisAlignment.start,
        children: widget.items
            .map(
              (item) => Container(
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
                          Row(
                            children: [
                              Text(
                                '잔여 수량:',
                                style: TextStyle(
                                  color: Color.fromARGB(255, 71, 70, 70),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                item.stock.toString() ?? '0',
                                style: TextStyle(
                                  color: Color.fromARGB(255, 196, 26, 20),
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700,
                                ),
                                overflow: TextOverflow.ellipsis,
                              )
                            ],
                          ),
                          SizedBox(height: 3),
                          Text(
                            item.title ?? '',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w900,
                              overflow: TextOverflow.ellipsis,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: 3),
                          Text(
                            item.location ?? '장소 미정',
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
            )
            .toList(),
      ),
    );
  }
}
