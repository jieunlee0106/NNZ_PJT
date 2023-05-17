import 'package:flutter/material.dart';
import 'package:nnz/src/config/config.dart';
import 'package:marquee/marquee.dart';
import 'package:nnz/src/pages/share/sharing_perform.dart';

class SportsCard extends StatelessWidget {
  final String AteamLogo;
  final String BteamLogo;
  final String AteamName;
  final String BteamName;
  final String date;
  final String location;
  final int id;

  SportsCard({
    required this.AteamLogo,
    required this.BteamLogo,
    required this.AteamName,
    required this.BteamName,
    required this.date,
    required this.location,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => SharePerformDetail(showIds: id)),
        );
      },
      child: Container(
        child: Column(
          children: [
            Column(
              children: [
                SizedBox(
                  height: 16,
                ),
                Container(
                  width: 340,
                  height: 85,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.7),
                        spreadRadius: 1,
                        blurRadius: 3,
                        offset: Offset(0, 5),
                      ),
                    ],
                    color: Colors.white,
                    border: Border.all(
                      color: Color(0xff111111),
                    ),
                    borderRadius: BorderRadius.circular(7),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              date,
                              style: TextStyle(fontSize: 14),
                            ),
                            SizedBox(
                              height: 4,
                            ),
                            Text(
                              location,
                              style: TextStyle(
                                  color: Color.fromARGB(255, 12, 12, 12),
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
                          children: [
                            Expanded(
                              flex: 3,
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Container(
                                      width: 22,
                                      height: 22,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        color: const Color.fromARGB(
                                            255, 255, 253, 253),
                                        image: DecorationImage(
                                          image: NetworkImage(AteamLogo),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      AteamName,
                                      style: TextStyle(
                                          color:
                                              Color.fromARGB(255, 12, 12, 12),
                                          fontSize: 13,
                                          fontWeight: FontWeight.w700),
                                      // 텍스트 중앙 정렬
                                      maxLines: 1, // 최대 2줄로 제한
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Text(
                                'VS',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 3,
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Container(
                                      width: 22,
                                      height: 22,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        color: const Color.fromARGB(
                                            255, 255, 253, 253),
                                        image: DecorationImage(
                                          image: NetworkImage(BteamLogo),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      BteamName,
                                      style: TextStyle(
                                          color:
                                              Color.fromARGB(255, 12, 12, 12),
                                          fontSize: 13,
                                          fontWeight: FontWeight.w700),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                    ),
                                  ],
                                ),
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
      ),
    );
  }
}
