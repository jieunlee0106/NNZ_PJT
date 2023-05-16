import 'package:flutter/material.dart';
import 'package:nnz/src/config/config.dart';

class ShareStockBox extends StatefulWidget {
  const ShareStockBox({super.key});

  @override
  State<ShareStockBox> createState() => _ShareStockBoxState();
}

class _ShareStockBoxState extends State<ShareStockBox> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      width: double.infinity,
      decoration: BoxDecoration(color: Config.yellowColor),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const Column(
              children: [
                SizedBox(
                  height: 5,
                ),
                Text(
                  "전체 수량",
                  style: TextStyle(color: Colors.grey, fontSize: 14),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "40",
                  style: TextStyle(fontSize: 30),
                )
              ],
            ),
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey,
                  width: 0.1,
                ),
              ),
            ),
            const Column(
              children: [
                SizedBox(
                  height: 5,
                ),
                Text(
                  "남은 수량",
                  style: TextStyle(color: Colors.grey, fontSize: 14),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "35",
                  style: TextStyle(fontSize: 30),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
