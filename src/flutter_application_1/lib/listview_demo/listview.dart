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
      home: Scaffold(
        body: HomeContent(),
      ),
    );
  }
}

class HomeContent extends StatelessWidget {
  const HomeContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    return ListView(
      children: <Widget>[
        const ListTile(
          leading: Icon(Icons.ac_unit),
          title: Text('main 1'),
          subtitle: Text('sub 1'),
        ),
        ListTile(
          leading: Image.asset('images/beauty.jpeg'),
          title: const Text('main 2'),
          subtitle: const Text('sub 2'),
          trailing: const Icon(Icons.settings),
        ),
        const ListTile(
          leading: Icon(Icons.backpack),
          title: Text('main 3'),
          subtitle: Text('sub 3'),
        ),
      ],
    );
  }
  
}