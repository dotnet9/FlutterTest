import 'package:flutter/material.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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

  Widget _titleWidget(value) {
    return Container(
      height: ScreenUtil().setHeight(34),
      margin: EdgeInsets.only(left: ScreenUtil().setWidth(20)),
      padding: EdgeInsets.only(left: ScreenUtil().setWidth(20)),
      decoration: BoxDecoration(
        border: Border(
          left: BorderSide(
            color: Colors.red,
            width: ScreenUtil().setWidth(10),
          )
        )
      ),
      child: Text(value, style: TextStyle(
        color: Colors.black54,
        fontSize: ScreenUtil().setSp(26)
      ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        _swiperWidget(),
        const SizedBox(height: 10),
        _titleWidget('猜你喜欢'),
        const SizedBox(height: 10),
        _titleWidget('热门推荐')
      ],
    );
  }
}
