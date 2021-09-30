import 'package:flutter/material.dart';

// 配置路由
final router = {
  '/': (context) => Tab(),
};

// 固定写法
var onGenerateRoute = (RouteSettings settings) {

  // 统一处理
  final String? name = settings.name;
  final Function pageContentBuilder = router[name] as Function;
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
};