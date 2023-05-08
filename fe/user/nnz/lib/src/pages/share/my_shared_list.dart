import 'package:flutter/material.dart';
import 'package:nnz/src/components/my_page_form/share_list_info.dart';
import 'package:nnz/src/config/config.dart';
import 'package:nnz/src/components/icon_data.dart';

class MySharedList extends StatelessWidget {
  const MySharedList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          iconTheme: const IconThemeData(color: Colors.black),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: Center(child: Image.asset(ImagePath.logo, width: 80)),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      '나눔 참여 리스트!',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  height: 5,
                  decoration: BoxDecoration(
                    color: Config.yellowColor,
                  ),
                ),
                ShareList(),
              ],
            ),
          ),
        ));
  }
}
