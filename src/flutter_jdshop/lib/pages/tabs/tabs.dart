import 'package:flutter/material.dart';
import 'cart_page.dart';
import 'category_page.dart';
import 'user_page.dart';
import 'home_page.dart';

class Tabs extends StatefulWidget {
  const Tabs({Key? key}) : super(key: key);

  @override
  _TabsState createState() => _TabsState();
}

class _TabsState extends State<Tabs> {
  int _currentIndex = 0;
  late PageController _pageController;

  @override
  void initState() { 
    super.initState();
    _pageController = PageController(initialPage: _currentIndex);
  }

  final List<Widget> _pageList = [
    const HomePage(),
    const CategoryPage(),
    const CartPage(),
    const UserPage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('LEQU.CO'),
      ),
      body: PageView(
        controller: _pageController,
        children: _pageList,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
            _pageController.jumpToPage(index);
          });
        },
        type: BottomNavigationBarType.fixed,
        fixedColor: Colors.red,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home), 
            label: '首页'
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.category), 
            label: '分类'
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart), 
            label: '购物车'
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people), 
            label: '我的'
          ),
        ],
      ),
    );
  }
}
