import 'package:flutter/material.dart';
import 'package:flutter_jdshop/routers/router.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(750, 1334),  // 配置设计稿的宽度高度
      builder: () => const MaterialApp(
        //home: Tabs(),
        initialRoute: '/',
        onGenerateRoute: onGenerateRoute
      ),
    );
  }
}
