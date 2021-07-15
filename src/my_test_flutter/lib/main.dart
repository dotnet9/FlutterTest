import 'package:flutter/material.dart';

import 'components/narbar.dart';
import 'components/will_pop_scope_test_route.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("title"),
        ),
        body: Center(
          // ignore: prefer_const_literals_to_create_immutables
          child: Column(children: [
            //背景为蓝色，则title自动为白色
            const NavBar(color: Colors.blue, title: "标题"),
            //背景为白色，则title自动为黑色
            const NavBar(color: Colors.white, title: "标题"),
          ]),
        ));
  }
}
