import 'package:flutter/material.dart';
import 'package:nnz/src/config/config.dart';
import 'package:get/get.dart';

class SharingInfo extends StatelessWidget {
  // 나눔 한 / 받은
  final String share;
  final String total;
  final String yet;
  final String ing;
  final String end;
  final Widget page;

  SharingInfo({
    super.key,
    required this.share,
    required this.total,
    required this.yet,
    required this.ing,
    required this.end,
    required this.page,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 40, left: 20, right: 20),
      child: Column(
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      share,
                      style: TextStyle(
                        color: Config.blackColor,
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    GestureDetector(
                      child: Text('더보기'),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => page),
                        );
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Container(
                width: 340,
                height: 100,
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 249, 241, 214),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            '전체',
                            style: TextStyle(fontSize: 14),
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          Text(
                            total,
                            style: TextStyle(
                                color: Color(0xffFF6666),
                                fontSize: 16,
                                fontWeight: FontWeight.w700),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 1,
                      height: 60,
                      color: Colors.black,
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 20),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  '나눔 전',
                                  style: TextStyle(fontSize: 14),
                                ),
                                SizedBox(
                                  height: 4,
                                ),
                                Text(
                                  yet,
                                  style: TextStyle(
                                      color: Color(0xff848484),
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 20),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  '나눔 중',
                                  style: TextStyle(fontSize: 14),
                                ),
                                SizedBox(
                                  height: 4,
                                ),
                                Text(
                                  ing,
                                  style: TextStyle(
                                      color: Color(0xff848484),
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 20),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  '종료',
                                  style: TextStyle(fontSize: 14),
                                ),
                                SizedBox(
                                  height: 4,
                                ),
                                Text(
                                  end,
                                  style: TextStyle(
                                      color: Color(0xff848484),
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
