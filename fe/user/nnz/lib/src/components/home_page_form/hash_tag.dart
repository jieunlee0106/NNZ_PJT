import 'package:flutter/material.dart';
import 'package:nnz/src/config/config.dart';

class HashTag extends StatelessWidget {
  const HashTag({Key? key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              margin: const EdgeInsets.all(10),
              // padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Wrap(
                spacing: 8,
                runSpacing: 8,
                children: List.generate(
                  8,
                  (index) => Container(
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
                      color: Color.fromARGB(255, 251, 247, 185),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      "#해시태그$index",
                      style: TextStyle(
                        color: Config.blackColor,
                        fontWeight: FontWeight.bold,
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
