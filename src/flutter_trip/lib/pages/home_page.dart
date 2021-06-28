import 'package:flutter/material.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List _imageUrls = [
    'https://git.imweb.io/dotnet9/imgs/raw/master/dotnet9_com/wp-content/uploads/2020/09/Controls.Dark_-1024x576.png',
    'https://git.imweb.io/dotnet9/imgs/raw/master/dotnet9_com/wp-content/uploads/2020/02/05_AduSkin_SuperEvil.png',
    'https://git.imweb.io/dotnet9/imgs/raw/master/dotnet9_com/wp-content/uploads/2019/12/4_Overview-dark-1024x810.png'
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: <Widget>[
            Container(
              height: 160,
              child: Swiper(
                itemCount: _imageUrls.length,
                autoplay: true,
                itemBuilder: (BuildContext context, int index) {
                  return Image.network(
                    _imageUrls[index],
                    fit: BoxFit.fill,
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
