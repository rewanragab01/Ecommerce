import 'package:flutter/material.dart';

class SnackBarMessage extends StatelessWidget {
  final String message;

  const SnackBarMessage({
    Key? key,
    required this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SnackBar(
      content: Text(message),
      backgroundColor: Color(0xffFD6E87),
    );
  }

  void show(BuildContext context, String message,
      {Color backgroundColor = Colors.red}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBarMessage(
        message: message,
      ) as SnackBar,
    );
  }
}
