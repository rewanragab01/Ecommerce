import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class Page_Indicator extends StatelessWidget {
  const Page_Indicator({
    super.key,
    required int currentPage,
    required PageController controller,
  })  : _currentPage = currentPage,
        _controller = controller;

  final int _currentPage;
  final PageController _controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      alignment: const Alignment(0, 0.9),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _currentPage == 0
              ? const SizedBox(width: 50) // Use an empty SizedBox for spacing
              : GestureDetector(
                  onTap: () {
                    _controller.previousPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                  },
                  child: const Text(
                    'Prev',
                    style: TextStyle(
                        color: Color(0xffC4C4C4),
                        fontSize: 18,
                        fontWeight: FontWeight.w500),
                  ),
                ),
          SmoothPageIndicator(controller: _controller, count: 3),
          GestureDetector(
            onTap: () {
              if (_currentPage < 2) {
                _controller.nextPage(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
              } else {
                Navigator.pushNamed(context, '/login');
              }
            },
            child: const Text(
              'Next',
              style: TextStyle(
                  color: Color(0xFFF83758),
                  fontSize: 20,
                  fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }
}
