import 'package:flutter/material.dart';

class BuildBottomAppBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onTabSelected;

  const BuildBottomAppBar({
    required this.selectedIndex,
    required this.onTabSelected,
  });

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      notchMargin: 8,
      height: 65,
      clipBehavior: Clip.antiAlias,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: () {
              onTabSelected(0);
            },
            icon: Icon(
              Icons.home_sharp,
              size: 30,
              color: selectedIndex == 0 ? Color(0xffEB3030) : Colors.black,
            ),
          ),
          IconButton(
            onPressed: () {
              onTabSelected(1);
            },
            icon: Icon(
              Icons.favorite_outline,
              size: 30,
              color: selectedIndex == 1 ? Color(0xffEB3030) : Colors.black,
            ),
          ),
          IconButton(
            onPressed: () {
              onTabSelected(2);
            },
            icon: Icon(
              Icons.search,
              size: 30,
              color: selectedIndex == 2 ? Color(0xffEB3030) : Colors.black,
            ),
          ),
          IconButton(
            onPressed: () {
              onTabSelected(3);
            },
            icon: Icon(
              Icons.settings,
              size: 30,
              color: selectedIndex == 3 ? Color(0xffEB3030) : Colors.black,
            ),
          ),
        ],
      ),
      shape: const CircularNotchedRectangle(),
    );
  }
}
