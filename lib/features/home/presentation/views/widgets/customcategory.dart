import 'package:flutter/material.dart';

class CustomCategory extends StatelessWidget {
  CustomCategory({
    required this.categoryname,
    required this.imageurl,
    required this.onpress,
  });

  final String categoryname;
  final String imageurl;
  final void Function()? onpress;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          child: Container(
            width: 150,
            height: 150,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              image: DecorationImage(
                fit: BoxFit.fill,
                image: NetworkImage(imageurl),
              ),
            ),
          ),
        ),
        Expanded(
          child: Text(
            categoryname,
            style: TextStyle(
              color: Colors.blue,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
        IconButton(
          onPressed: onpress,
          icon: Icon(
            Icons.keyboard_arrow_right_rounded,
            color: Color(0xffFD6E87),
            size: 30,
          ),
        ),
      ],
    );
  }
}
