import 'package:ecommerce/features/favourite/presentation/views/favouritescreen.dart';
import 'package:ecommerce/features/home/presentation/views/widgets/buildbottombar.dart';
import 'package:ecommerce/features/home/presentation/views/widgets/homescreen.dart';
import 'package:ecommerce/features/home/presentation/views/widgets/searchscreen.dart';
import 'package:ecommerce/features/home/presentation/views/widgets/settingscreen.dart';
import 'package:ecommerce/features/shoppingcart/presentation/views/shoppingcart.dart';
import 'package:flutter/material.dart';

class HomeBody extends StatefulWidget {
  const HomeBody({
    super.key,
  }); // Add initialBackgroundColor
  @override
  State<HomeBody> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  int _selectindex = 0;
  bool isFabClicked = false;
  Color backgroundColor = Colors.white;

  final List<Widget> _pages = [
    HomeScreen(),
    FavouriteScreen(),
    SearchScreen(),
    SettingsScreen(),
    ShoppingCartScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _selectindex = 4;
            isFabClicked = !isFabClicked;
            backgroundColor = Color(0xffFD6E87);
          });
        },
        foregroundColor: Colors.black,
        elevation: 5,
        backgroundColor: backgroundColor,
        child: const Icon(Icons.shopping_cart_outlined),
        shape: const CircleBorder(),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BuildBottomAppBar(
        selectedIndex: _selectindex,
        onTabSelected: (index) {
          setState(() {
            _selectindex = index;
            isFabClicked = false;
            backgroundColor = Colors.white;
          });
        },
      ),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Image.asset(
          'assets/images/logo.png',
          height: 150,
          width: 150,
        ),
        leading: const Icon(Icons.menu_sharp),
        actions: const [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: CircleAvatar(
              backgroundImage: AssetImage('assets/images/profile.png'),
            ),
          )
        ],
      ),
      body: IndexedStack(
        index: _selectindex,
        children: _pages,
      ),
    );
  }
}
