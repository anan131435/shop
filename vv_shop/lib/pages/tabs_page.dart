import 'package:flutter/material.dart';
import 'package:vv_shop/pages/cart_page.dart';
import 'package:vv_shop/pages/category_page.dart';
import 'package:vv_shop/pages/home_page.dart';
import 'package:vv_shop/pages/user_page.dart';
class Tabs extends StatefulWidget {
  const Tabs({Key? key}) : super(key: key);

  @override
  State<Tabs> createState() => _TabsState();
}

class _TabsState extends State<Tabs> {

  int _currentIndex = 0;
  final List _pageList = const [
    HomePage(),
    CategoryPage(),
    CartPage(),
    UserPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("VVShop"),
        centerTitle: true,
      ),
      body: _pageList[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "首页"),
          BottomNavigationBarItem(icon: Icon(Icons.category), label:"分类"),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label:"购物车"),
          BottomNavigationBarItem(icon: Icon(Icons.people), label:"个人"),
        ],
      ),
    );
  }
}
