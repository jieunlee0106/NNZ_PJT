import 'package:flutter/material.dart';

class MyProfile extends StatelessWidget {
  final String? nickname;
  final String? profileImage;

  const MyProfile({
    required this.nickname,
    required this.profileImage,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 40,
            backgroundImage:
                NetworkImage(profileImage ?? 'https://via.placeholder.com/150'),
          ),
          SizedBox(height: 20),
          Text(
            nickname ?? '',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
