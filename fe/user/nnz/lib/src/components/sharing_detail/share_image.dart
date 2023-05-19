import 'package:flutter/material.dart';

class ShareImage extends StatelessWidget {
  const ShareImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/images/sharing_sample/sharingsource.jpg',
      width: 200,
      height: 200,
      fit: BoxFit.cover,
    );
  }
}
