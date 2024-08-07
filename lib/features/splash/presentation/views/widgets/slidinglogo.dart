import 'package:flutter/material.dart';

class SlidingLogo extends StatelessWidget {
  const SlidingLogo({
    Key? key,
    required this.slidingAnimation,
  }) : super(key: key);

  final Animation<Offset> slidingAnimation;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: slidingAnimation,
        builder: (context, _) {
          return SlideTransition(
            position: slidingAnimation,
            child: Image.asset(
              'assets/images/logo.png', // Replace with the path to your logo image
              height: 100, // Adjust the height as needed
              width: 100, // Adjust the width as needed
            ),
          );
        });
  }
}
