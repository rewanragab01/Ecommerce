import 'package:flutter/material.dart';

class CustomPage extends StatelessWidget {
  const CustomPage(
      {super.key,
      required this.image,
      required this.topic,
      required this.desc});
  final String image;
  final String topic;
  final String desc;
  @override
  Widget build(BuildContext context) {
    // Get screen dimensions
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: screenHeight * 0.19),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height:
                  screenHeight * 0.3, // Adjust height based on screen height
              width: screenWidth * 0.8, // Adjust width based on screen width
              child: Image.asset(image, fit: BoxFit.contain),
            ),
            SizedBox(
              height:
                  screenHeight * 0.07, // Adjust spacing based on screen height
            ),
            Text(
              topic,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: screenWidth *
                    0.07, // Adjust font size based on screen width
              ),
            ),
            SizedBox(
              height:
                  screenHeight * 0.02, // Adjust spacing based on screen height
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Center(
                child: Text(
                  desc,
                  textAlign: TextAlign.center, // Center the text horizontally
                  maxLines: 3, // Set the maximum number of lines
                  overflow: TextOverflow.ellipsis, // Handle overflow
                  style: TextStyle(
                    fontSize: 19.2,
                    color: const Color(0xffA8A8A9),
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
