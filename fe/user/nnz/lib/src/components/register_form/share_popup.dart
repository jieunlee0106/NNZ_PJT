import 'package:flutter/material.dart';

class sharePopup extends StatelessWidget {
  final popupMessage;
  const sharePopup({super.key, required this.popupMessage});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Text(popupMessage),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
            FocusScope.of(context).unfocus();
          },
          child: const Text("확인"),
        ),
      ],
    );
  }
}
