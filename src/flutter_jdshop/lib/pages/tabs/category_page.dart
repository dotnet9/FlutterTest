import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_jdshop/config/config.dart';
import 'package:flutter_jdshop/model/cate_model.dart';
import 'package:flutter_jdshop/services/screen_adaper.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({Key? key}) : super(key: key);

  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> with AutomaticKeepAliveClientMixin {
  int _selectedIndex = 0;
  List<CateItemModel> _leftCateList = [];
  List<CateItemModel> _rightCateList = [];

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _getLeftCateData();
  }

  _getLeftCateData() async {
    var api = '${Config.domain}api/pcate';
    var result = await Dio().get(api);
    var leftCateList = CateModel.fromJson(result.data);
    setState(() {
      _leftCateList = leftCateList.result;
    });
    _getRightCateData(leftCateList.result[0].sId);
  }

  _getRightCateData(pid) async {
    var api = '${Config.domain}api/pcate?pid=$pid';
    var result = await Dio().get(api);
    var rightCateList = CateModel.fromJson(result.data);
    setState(() {
      _rightCateList = rightCateList.result;
    });
  }

  Widget _leftCateWidget(leftWidth) {
    if (_leftCateList.isNotEmpty) {
      return Container(
        width: leftWidth,
        height: double.infinity,
        child: ListView.builder(
            itemCount: _leftCateList.length,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  InkWell(
                    onTap: () {
                      setState(() {
                        _selectedIndex = index;
                        _getRightCateData(_leftCateList[index].sId);
                      });
                    },
                    child: Container(
                      width: double.infinity,
                      height: ScreenAdaper.height(84),
                      padding: EdgeInsets.only(top: ScreenAdaper.height(24)),
                      child: Text(_leftCateList[index].title ?? '',
                          textAlign: TextAlign.center),
                      color: (_selectedIndex == index
                          ? const Color.fromRGBO(240, 246, 246, 0.9)
                          : Colors.white),
                    ),
                  ),
                  const Divider(height: 1)
                ],
              );
            }),
      );
    } else {
      return Container(
        width: leftWidth,
        height: double.infinity,
      );
    }
  }

  Widget _rightCateWidget(rightItemWidth, rightItemHeight) {
    if (_rightCateList.isNotEmpty) {
      return Expanded(
          flex: 1,
          child: Container(
            padding: const EdgeInsets.all(10),
            height: double.infinity,
            color: const Color.fromRGBO(240, 246, 246, 0.9),
            child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: rightItemHeight / rightItemHeight,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10),
                itemCount: _rightCateList.length,
                itemBuilder: (context, index) {
                  String pic = _rightCateList[index].pic ?? '';
                  pic = Config.domain + pic.replaceAll('\\', '/');

                  return Container(
                    child: Column(
                      children: [
                        AspectRatio(
                          aspectRatio: 1 / 1,
                          child: Image.network(pic, fit: BoxFit.cover),
                        ),
                        SizedBox(
                          height: ScreenAdaper.height(28),
                          child: Text(_rightCateList[index].title ?? ''),
                        )
                      ],
                    ),
                  );
                }),
          ));
    } else {
      return Expanded(
        flex: 1,
        child: Container(
          padding: const EdgeInsets.all(10),
          height: double.infinity,
          color: const Color.fromRGBO(240, 246, 246, 0.9),
          child: const Text('加载中...'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    var leftWidth = ScreenAdaper.getScreenWidth() / 4;
    var rightItemWidth =
        (ScreenAdaper.getScreenWidth() - leftWidth - 20 - 20) / 3;
    rightItemWidth = ScreenAdaper.width(rightItemWidth);
    var rightItemHeight = rightItemWidth + ScreenAdaper.height(28);

    return Row(
      children: [
        _leftCateWidget(leftWidth),
        _rightCateWidget(rightItemWidth, rightItemHeight)
      ],
    );
  }
}
