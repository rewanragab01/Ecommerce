import 'package:flutter/material.dart';

import 'widgets/custompage.dart';
import 'widgets/pageindicator.dart';
import 'widgets/uppercount.dart';

class OnboardingScreens extends StatefulWidget {
  const OnboardingScreens({super.key});

  @override
  State<OnboardingScreens> createState() => _OnboardingScreensState();
}

class _OnboardingScreensState extends State<OnboardingScreens> {
  final PageController _controller = PageController();
  int _currentPage = 0;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _controller,
            onPageChanged: (int index) {
              setState(() {
                _currentPage = index;
              });
            },
            children: const [
              PageOne(),
              PageTwo(),
              PageThree(),
            ],
          ),
          Upper_Count(currentPage: _currentPage, controller: _controller),
          Page_Indicator(currentPage: _currentPage, controller: _controller),
        ],
      ),
    );
  }
}

class PageThree extends StatelessWidget {
  const PageThree({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const CustomPage(
        image: 'assets/images/page3.png',
        topic: 'Get Your Order',
        desc:
            'Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint. Velit officia consequat duis enim velit mollit.');
  }
}

class PageTwo extends StatelessWidget {
  const PageTwo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const CustomPage(
        image: 'assets/images/page2.png',
        topic: 'Make Payment',
        desc:
            'Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint. Velit officia consequat duis enim velit mollit.');
  }
}

class PageOne extends StatelessWidget {
  const PageOne({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const CustomPage(
        image: 'assets/images/page1.png',
        topic: 'Choose Product',
        desc:
            'Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint. Velit officia consequat duis enim velit mollit.');
  }
}
