import 'package:flutter/material.dart';

class Upper_Count extends StatelessWidget {
  const Upper_Count({
    super.key,
    required int currentPage,
    required PageController controller,
  })  : _currentPage = currentPage,
        _controller = controller;

  final int _currentPage;
  final PageController _controller;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 40.0,
      left: 16.0,
      right: 16.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text.rich(
            TextSpan(
                text: '${_currentPage + 1}',
                style: const TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.w500),
                children: const [
                  TextSpan(
                      text: '/3',
                      style: TextStyle(
                          fontSize: 20,
                          color: Color(0xffC4C4C4),
                          fontWeight: FontWeight.w500))
                ]),
          ),
          GestureDetector(
            onTap: () {
              // Skip to the last page or any specific action
              _controller.jumpToPage(2); // Assuming there are 3 pages
            },
            child: const Text(
              'Skip',
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: 20),
            ),
          ),
        ],
      ),
    );
  }
}
