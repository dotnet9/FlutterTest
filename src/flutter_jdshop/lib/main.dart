import 'package:flutter/material.dart';
import 'package:flutter_jdshop/routers/router.dart';

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
    return MaterialApp(
      //home: Tabs(),
      initialRoute: '/',
      onGenerateRoute: onGenerateRoute
    );
  }
}
