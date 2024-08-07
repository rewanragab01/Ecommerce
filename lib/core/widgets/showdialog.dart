import 'package:flutter/material.dart';

class ShowDialog extends StatelessWidget {
  final String title;
  final String content;
  final Function() onPressed;

  const ShowDialog({
    super.key,
    required this.title,
    required this.content,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: <Widget>[
        TextButton(
          onPressed: onPressed,
          child: const Text('OK'),
        ),
      ],
    );
  }
}
