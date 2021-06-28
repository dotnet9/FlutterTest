import 'package:flutter/material.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List _imageUrls = [
    'https://git.imweb.io/dotnet9/imgs/raw/master/dotnet9_com/wp-content/uploads/2020/09/Controls.Dark_-1024x576.png',
    'https://git.imweb.io/dotnet9/imgs/raw/master/dotnet9_com/wp-content/uploads/2019/12/4_Overview-dark-1024x810.png',
    'https://git.imweb.io/dotnet9/imgs/raw/master/dotnet9_com/wp-content/uploads/2020/02/04_AduSkin_HeartFM.png'
  ];

  _onScroll(offset) {
    print(offset);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MediaQuery.removePadding(
        removeTop: true,
        context: context,
        child: NotificationListener(
          onNotification: (scrollNotification) {
            if (scrollNotification is ScrollUpdateNotification &&
                scrollNotification.depth == 0) {
              // 滚动且是列表滚动的时候
              _onScroll(scrollNotification.metrics.pixels);
              return true;
            }

            return false;
          },
          child: ListView(
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
                  pagination: SwiperPagination(),
                ),
              ),
              Container(
                height: 800,
                child: ListTile(
                  title: Text('test'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
