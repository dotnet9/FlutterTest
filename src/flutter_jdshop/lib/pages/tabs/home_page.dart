import 'package:flutter/material.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // 轮播图
  Widget _swiperWidget() {
    List<Map> imgList = [
      {'url': 'https://dotnet9.com/wp-content/uploads/2021/10/slide1.jpeg'},
      {'url': 'https://dotnet9.com/wp-content/uploads/2021/10/slide2.gif'},
      {'url': 'https://dotnet9.com/wp-content/uploads/2021/10/slide3.jpeg'},
      {'url': 'https://dotnet9.com/wp-content/uploads/2021/10/slide4.jpeg'},
      {'url': 'https://dotnet9.com/wp-content/uploads/2021/10/slide5.jpeg'},
    ];

    return Container(
      child: AspectRatio(
        aspectRatio: 2 / 1,
        child: Swiper(
            itemBuilder: (BuildContext context, int index) {
              return Image.network(
                imgList[index]["url"],
                fit: BoxFit.fill,
              );
            },
            itemCount: imgList.length,
            pagination: const SwiperPagination(),
            control: const SwiperControl(),
            autoplay: true),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        _swiperWidget(),
      ],
    );
  }
}
