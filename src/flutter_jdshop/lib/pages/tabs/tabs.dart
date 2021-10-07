import 'package:flutter/material.dart';
import 'package:flutter_jdshop/services/screen_adapter.dart';
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
      appBar: _currentIndex != 3
          ? AppBar(
              leading: const IconButton(
                icon: Icon(Icons.center_focus_weak,
                    size: 28, color: Colors.black87),
                onPressed: null,
              ),
              title: InkWell(
                child: Container(
                  height: ScreenAdapter.height(68),
                  decoration: BoxDecoration(
                      color: const Color.fromRGBO(233, 233, 233, 0.8),
                      borderRadius: BorderRadius.circular(30)),
                  padding: EdgeInsets.only(left: 10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Icon(Icons.search),
                      Text('笔记本',
                          style: TextStyle(fontSize: ScreenAdapter.size(28)))
                    ],
                  ),
                ),
                onTap: () {
                  Navigator.pushNamed(context, '/search');
                },
              ),
              actions: const [
                IconButton(
                    onPressed: null,
                    icon: Icon(Icons.message, size: 28, color: Colors.black87))
              ],
            )
          : AppBar(title: const Text('用户中心')),
      body: PageView(
        controller: _pageController,
        children: _pageList,
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
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
          BottomNavigationBarItem(icon: Icon(Icons.home), label: '首页'),
          BottomNavigationBarItem(icon: Icon(Icons.category), label: '分类'),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart), label: '购物车'),
          BottomNavigationBarItem(icon: Icon(Icons.people), label: '我的'),
        ],
      ),
    );
  }
}
