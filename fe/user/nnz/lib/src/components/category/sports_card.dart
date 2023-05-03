import 'package:flutter/material.dart';
import 'package:nnz/src/config/config.dart';
import 'package:marquee/marquee.dart';

class SportsCard extends StatelessWidget {
  final String AteamLogo;
  final String BteamLogo;
  final String AteamName;
  final String BteamName;
  final String date;
  final String location;

  SportsCard({
    required this.AteamLogo,
    required this.BteamLogo,
    required this.AteamName,
    required this.BteamName,
    required this.date,
    required this.location,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 20),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(AteamLogo),
                                Text(
                                  AteamName,
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 12, 12, 12),
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700),
                                ),
                              ],
                            ),
                          ),
                          Text(
                            'VS',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 20),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(BteamLogo),
                                Text(
                                  BteamName,
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 12, 12, 12),
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
