import 'package:flutter/material.dart';
import 'package:flutter_jdshop/services/screen_adaper.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Map> _imgList = [
    {'url': 'https://dotnet9.com/wp-content/uploads/2021/10/slide1.jpeg'},
    {'url': 'https://dotnet9.com/wp-content/uploads/2021/10/slide2.gif'},
    {'url': 'https://dotnet9.com/wp-content/uploads/2021/10/slide2.jpeg'},
    {'url': 'https://dotnet9.com/wp-content/uploads/2021/10/slide3.jpeg'},
    {'url': 'https://dotnet9.com/wp-content/uploads/2021/10/slide4.jpeg'},
    {'url': 'https://dotnet9.com/wp-content/uploads/2021/10/slide5.jpeg'},
  ];

  // 轮播图
  Widget _swiperWidget() {
    return Container(
      child: AspectRatio(
        aspectRatio: 2 / 1,
        child: Swiper(
            itemBuilder: (BuildContext context, int index) {
              return Image.network(
                _imgList[index]["url"],
                fit: BoxFit.fill,
              );
            },
            itemCount: _imgList.length,
            pagination: const SwiperPagination(),
            control: const SwiperControl(),
            autoplay: true),
      ),
    );
  }

  Widget _titleWidget(value) {
    return Container(
      height: ScreenAdaper.height(32),
      margin: EdgeInsets.only(left: ScreenAdaper.width(20)),
      padding: EdgeInsets.only(left: ScreenAdaper.width(20)),
      decoration: BoxDecoration(
          border: Border(
              left: BorderSide(
        color: Colors.red,
        width: ScreenAdaper.width(10),
      ))),
      child: Text(
        value,
        style: const TextStyle(color: Colors.black54),
      ),
    );
  }

  // 猜你喜欢
  Widget _youLikeListWidget() {
    return Container(
        height: ScreenAdaper.height(254),
        padding: EdgeInsets.all(ScreenAdaper.width(20)),
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return Column(
              children: [
                Container(
                  height: ScreenAdaper.height(140),
                  width: ScreenAdaper.width(140),
                  margin: EdgeInsets.only(right: ScreenAdaper.width(21)),
                  child:
                      Image.network(_imgList[index]['url'], fit: BoxFit.cover),
                ),
                Container(
                  padding: EdgeInsets.only(top: ScreenAdaper.height(10)),
                  height: ScreenAdaper.height(44),
                  child: Text('第${index + 1}条'),
                )
              ],
            );
          },
          itemCount: _imgList.length,
        ));
  }

  // 热门推荐
  _recProductItemWidget(int index) {
    var itemWidth = (ScreenAdaper.getScreenWidth() - 30) / 2;

    return Container(
      padding: const EdgeInsets.all(10),
      width: itemWidth,
      decoration: BoxDecoration(
          border: Border.all(
              color: const Color.fromRGBO(233, 233, 233, 0.9), width: 1)),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            child: AspectRatio(
              // 防止服务器返回的图片大小不一致导致高度不一致问题
              aspectRatio: 1 / 1,
              child: Image.network(_imgList[index]['url'], fit: BoxFit.cover),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: ScreenAdaper.height(20)),
            child: const Text(
              '2021夏季新款气质高贵洋气阔太太有女人味中长款宽松大码',
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: Colors.black54),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: ScreenAdaper.height(20)),
            child: Stack(
              children: const [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    '￥188.0',
                    style: TextStyle(color: Colors.red, fontSize: 16),
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text('￥198.0',
                      style: TextStyle(
                          color: Colors.black54,
                          fontSize: 14,
                          decoration: TextDecoration.lineThrough)),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        _swiperWidget(),
        SizedBox(height: ScreenAdaper.height(10)),
        _titleWidget('猜你喜欢'),
        SizedBox(height: ScreenAdaper.height(10)),
        _youLikeListWidget(),
        _titleWidget('热门推荐'),
        Container(
          padding: const EdgeInsets.all(10),
          child: Wrap(
            runSpacing: 10,
            spacing: 10,
            children: [
              _recProductItemWidget(0),
              _recProductItemWidget(1),
              _recProductItemWidget(2),
              _recProductItemWidget(3),
              _recProductItemWidget(4),
              _recProductItemWidget(5),
            ],
          ),
        )
      ],
    );
  }
}
