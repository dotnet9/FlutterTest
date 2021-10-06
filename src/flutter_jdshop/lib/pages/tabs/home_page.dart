import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_jdshop/config/config.dart';
import 'package:flutter_jdshop/model/focus_model.dart';
import 'package:flutter_jdshop/model/product_model.dart';
import 'package:flutter_jdshop/services/screen_adaper.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<FocusItemModel> _focusData = [];
  List<ProductItemModel> _hotProductList = [];
  List<ProductItemModel> _bestProductList = [];

  @override
  void initState() {
    super.initState();
    _getFocusData();
    _getHotProductData();
    _getBestProductData();
  }

  // 获取轮播图数据
  _getFocusData() async {
    var api = '${Config.domain}api/focus';
    var result = await Dio().get(api);
    var focusList = FocusModel.fromJson(result.data);

    setState(() {
      _focusData = focusList.result;
    });
  }

  // 获取猜你喜欢的数据
  _getHotProductData() async {
    var api = '${Config.domain}api/plist?is_hot=1';
    var result = await Dio().get(api);
    var hotProductList = ProductModel.fromJson(result.data);
    setState(() {
      _hotProductList = hotProductList.result;
    });
  }

  // 获取热门推荐的数据
  _getBestProductData() async {
    var api = '${Config.domain}api/plist?is_best=1';
    var result = await Dio().get(api);
    var bestProductList = ProductModel.fromJson(result.data);
    setState(() {
      _bestProductList = bestProductList.result;
    });
  }

  // 轮播图
  Widget _swiperWidget() {
    if (_focusData.isNotEmpty) {
      return Container(
        child: AspectRatio(
          aspectRatio: 2 / 1,
          child: Swiper(
              itemBuilder: (BuildContext context, int index) {
                String pic = _focusData[index].pic ?? '';
                pic = Config.domain + pic.replaceAll('\\', '/');
                return Image.network(pic, fit: BoxFit.fill);
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

  // 热门商品
  Widget _hotProductListWidget() {
    if (_hotProductList.isNotEmpty) {
      return Container(
            height: ScreenAdaper.height(254),
            padding: EdgeInsets.all(ScreenAdaper.width(20)),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                String sPic = _hotProductList[index].sPic ?? '';
                sPic = Config.domain + sPic.replaceAll('\\', '/');

                return Column(
                  children: [
                    Container(
                      height: ScreenAdaper.height(140),
                      width: ScreenAdaper.width(140),
                      margin: EdgeInsets.only(right: ScreenAdaper.width(21)),
                      child: Image.network(sPic, fit: BoxFit.cover),
                    ),
                    Container(
                      padding: EdgeInsets.only(top: ScreenAdaper.height(10)),
                      height: ScreenAdaper.height(44),
                      child: Text(
                        '￥${_hotProductList[index].price}', 
                        style: const TextStyle(color: Colors.red),),
                    )
                  ],
                );
              },
              itemCount: _bestProductList.length,
            ),
            );
    } else {
      return const Text('');
    }
  }

  // 推荐商品
  _recProductListWidget() {

    var itemWidth = (ScreenAdaper.getScreenWidth() - 30) / 2;

    return Container(
      padding: const EdgeInsets.all(10),
      child: Wrap(
        runSpacing: 10,
        spacing: 10,
        children: _bestProductList.map((value) {

          String sPic = value.sPic ?? '';
          sPic = Config.domain + sPic.replaceAll('\\', '/');

          return Container(
            padding: const EdgeInsets.all(10),
            width: itemWidth,
            decoration: BoxDecoration(
              border: Border.all(
                color: const Color.fromRGBO(233, 233, 233, 0.9),
                width: 1
              ),
            ),
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  child: AspectRatio(
                    aspectRatio: 1 / 1,
                    child: Image.network(
                      sPic,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: ScreenAdaper.height(20)),
                  child: Text(
                    value.title ?? '',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(color: Colors.black54),
                  )
                ),
                Padding(
                  padding: EdgeInsets.only(top: ScreenAdaper.height(20)),
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          '￥${value.price}',
                          style: const TextStyle(color: Colors.red, fontSize: 16),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          '￥${value.oldPrice}',
                          style: const TextStyle(
                            color: Colors.black54,
                            fontSize: 14,
                            decoration: TextDecoration.lineThrough
                          )
                        ),
                      )
                    ],
                  ),
                )
              ],),
          );
        }).toList(),
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
        _hotProductListWidget(),
        _titleWidget('热门推荐'),
        _recProductListWidget()
      ],
    );
  }
}
