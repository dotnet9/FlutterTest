import 'package:flutter/material.dart';  

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter demo',
      home: HomeContent(),
    );
  }
}

class HomeContent extends StatelessWidget {
  const HomeContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    return Center(
      child: Image.network(
        'https://dotnet9.com/wp-content/uploads/2020/05/logo-head.png',
        alignment: Alignment.bottomRight
      ),
    );
  }
  
}