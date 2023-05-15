import 'package:flutter/material.dart';
import 'package:nnz/src/config/config.dart';
import 'package:nnz/src/model/hash_tag_model.dart';
import 'package:nnz/src/pages/search/tag_page.dart';

class HashTag extends StatelessWidget {
  final List<HashTagModel> items;
  const HashTag({Key? key, required this.items}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Wrap(
                spacing: 8,
                runSpacing: 8,
                children: List.generate(
                  items.length,
                  (index) => InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => TagPage()),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.7),
                            spreadRadius: 1,
                            blurRadius: 3,
                            offset: Offset(0, 5),
                          ),
                        ],
                        color: Config.rigthYellowColor,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        items[index].tag,
                        style: TextStyle(
                          color: Config.blackColor,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class OtherScreen extends StatelessWidget {
  const OtherScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Other Screen'),
      ),
      body: Center(
        child: Text('This is the Other Screen'),
      ),
    );
  }
}
