import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_jdshop/model/focus_model.dart';
import 'package:flutter_jdshop/services/screen_adaper.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List _focusData = [];

  @override
  void initState() {
    super.initState();
    _getFocusData();
  }

  _getFocusData() async {
    var api = 'https://jd.itying.com/api/focus';
    var result = await Dio().get(api);
    var focusList = FocusModel.fromJson(result.data);

    setState(() {
      _focusData = focusList.result;
    });
  }

  // 轮播图
  Widget _swiperWidget() {
    if (_focusData.length > 0) {
      return Container(
        child: AspectRatio(
          aspectRatio: 2 / 1,
          child: Swiper(
              itemBuilder: (BuildContext context, int index) {
                String pic = this._focusData[index].pic;
                return Image.network(
                  'https://jd.itying.com/${pic.replaceAll("\\", "/")}',
                  fit: BoxFit.fill,
                );
              },
              itemCount: _focusData.length,
              pagination: const SwiperPagination(),
              control: const SwiperControl(),
              autoplay: true),
        ),
      );
    } else {
      return const Text('加载中');
    }
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
                  child: Image.network(
                      'https://www.itying.com/images/flutter/hot${index + 1}.jpg',
                      fit: BoxFit.cover),
                ),
                Container(
                  padding: EdgeInsets.only(top: ScreenAdaper.height(10)),
                  height: ScreenAdaper.height(44),
                  child: Text('第${index + 1}条'),
                )
              ],
            );
          },
          itemCount: 10,
        ));
  }

  // 热门推荐
  _recProductItemWidget() {
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
              child: Image.network('https://www.itying.com/images/flutter/list1.jpg', fit: BoxFit.cover),
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
        SizedBox(height: ScreenAdaper.height(20)),
        _titleWidget('猜你喜欢'),
        SizedBox(height: ScreenAdaper.height(20)),
        _youLikeListWidget(),
        _titleWidget('热门推荐'),
        Container(
          padding: const EdgeInsets.all(10),
          child: Wrap(
            runSpacing: 10,
            spacing: 10,
            children: [
              _recProductItemWidget(),
              _recProductItemWidget(),
              _recProductItemWidget(),
              _recProductItemWidget(),
              _recProductItemWidget(),
              _recProductItemWidget(),
            ],
          ),
        )
      ],
    );
  }
}
