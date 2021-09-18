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
      child: SizedBox(
        child: ClipOval(
          child: Image.asset(
            'images/beauty.jpeg',
            fit: BoxFit.cover),
        ),
        width: 250,
        height: 250,
      ),
    );
  }
  
}