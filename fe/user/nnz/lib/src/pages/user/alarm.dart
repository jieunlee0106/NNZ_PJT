import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nnz/src/components/gray_line_form/gray_line.dart';
import 'package:nnz/src/components/icon_data.dart';
import 'package:nnz/src/components/notification/my_noti_list.dart';
import 'package:nnz/src/components/notification/site_noti_list.dart';
import 'package:nnz/src/config/config.dart';
import 'package:nnz/src/controller/find_password_controller.dart';
import 'package:nnz/src/controller/notification_controller.dart';

class NotificationPage extends StatefulWidget {
  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  String _selectedTab = "활동";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        title: Center(child: Image.asset(ImagePath.logo, width: 80)),
        actions: [Icon(Icons.more_vert)],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                top: 20,
              ),
              child: Expanded(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        InkWell(
                          onTap: () {
                            setState(() {
                              _selectedTab = "활동";
                            });
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width / 2,
                            alignment: Alignment.center,
                            child: Text(
                              '활동',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: _selectedTab == "활동"
                                    ? Colors.black
                                    : Colors.grey,
                              ),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              _selectedTab = "공지";
                            });
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width / 2,
                            alignment: Alignment.center,
                            child: Text(
                              '공지',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: _selectedTab == "공지"
                                    ? Colors.black
                                    : Colors.grey,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      height: 1,
                      decoration: BoxDecoration(
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            _selectedTab == "활동" ? MyNotiList() : SiteNotiList(),
          ],
        ),
      ),
    );
  }
}
