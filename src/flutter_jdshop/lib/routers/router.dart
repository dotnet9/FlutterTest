import 'package:flutter/material.dart';
import 'package:flutter_jdshop/pages/product_list_page.dart';
import 'package:flutter_jdshop/pages/search_page.dart';
import 'package:flutter_jdshop/pages/tabs/tabs.dart';

// 配置路由
final Map<String, Function> router = {
  '/': (context) => const Tabs(),
  '/search': (context) => const SearchPage(),
  '/productList': (context, {arguments}) => ProductListPage(arguments: arguments),
};

// 固定写法
Route? onGenerateRoute(RouteSettings settings) {
  // 统一处理
  final String? name = settings.name;
  final Function? pageContentBuilder = router[name];
  if (pageContentBuilder != null) {
    if (settings.arguments != null) {
      final Route route = MaterialPageRoute(
          builder: (context) =>
              pageContentBuilder(context, arguments: settings.arguments));
      return route;
    } else {
      final Route route =
          MaterialPageRoute(builder: (context) => pageContentBuilder(context));
      return route;
    }
  }
  return null;
}
