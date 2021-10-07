import 'package:flutter/material.dart';
import 'package:flutter_jdshop/services/screen_adapter.dart';
import 'package:flutter_jdshop/services/search_services.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  var _keywords;
  List _historyListData = [];

  @override
  void initState() {
    super.initState();
    _getHistoryData();
  }

  _getHistoryData() async {
    var historyListData = await SearchServices.getHistoryList();
    setState(() {
      _historyListData = historyListData;
    });
  }

  _showAlertDialog(keywords) async {
    var result = await showDialog(
        barrierDismissible: false, // 表示点击灰色背景的时候是否消失弹出框
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('提示信息！'),
            content: Text('您确定要删除吗？'),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context, 'Cancle');
                  },
                  child: const Text('取消')),
              TextButton(
                  onPressed: () async {
                    await SearchServices.removeHistoryData(keywords);
                    _getHistoryData();
                    Navigator.pop(context, 'Ok');
                  },
                  child: const Text('确定'))
            ],
          );
        });
  }

  Widget _historyListWidget() {
    if (_historyListData.isNotEmpty) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child:
               Text('历史记录', style: Theme.of(context).textTheme.caption),
          ),
          const Divider(),
          Column(
            children: _historyListData.map((value) {
              return Column(
                children: [
                  ListTile(
                    title: Text(value),
                    onLongPress: () {
                      _showAlertDialog(value);
                    },
                  ),
                  const Divider()
                ],
              );
            }).toList(),
          ),
          const SizedBox(
            height: 100,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {
                  SearchServices.clearHistoryList();
                  _getHistoryData();
                },
                child: Container(
                  width: ScreenAdapter.width(400),
                  height: ScreenAdapter.height(64),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black45, width: 1)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [Icon(Icons.delete), Text('清空历史记录')],
                  ),
                ),
              )
            ],
          )
        ],
      );
    } else {
      return const Text('');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          child: TextField(
            autofocus: true,
            decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none)),
            onChanged: (value) {
              _keywords = value;
            },
          ),
          height: ScreenAdapter.height(68),
          decoration: BoxDecoration(
              color: const Color.fromRGBO(233, 233, 233, 0.8),
              borderRadius: BorderRadius.circular(30)),
        ),
        actions: [
          InkWell(
            child: Container(
              height: ScreenAdapter.height(68),
              width: ScreenAdapter.width(80),
              child: Row(
                children: const [Text('搜索')],
              ),
            ),
            onTap: () {
              SearchServices.setHistoryData(_keywords);
              Navigator.pushReplacementNamed(context, '/productList',
                  arguments: {'keywords': _keywords});
            },
          )
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: [
            Container(
              child: Text('热搜', style: Theme.of(context).textTheme.caption),
            ),
            const Divider(),
            Wrap(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  margin: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(233, 233, 233, 0.9),
                    borderRadius: BorderRadius.circular(10)
                  ),
                  child: const Text('女装'),
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  margin: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: const Color.fromRGBO(233, 233, 233, 0.9),
                    borderRadius: BorderRadius.circular(10)
                  ),
                  child: const Text('女装'),
                ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    margin: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: const Color.fromRGBO(233, 233, 233, 0.9),
                        borderRadius: BorderRadius.circular(10)),
                    child: const Text("笔记本电脑"),
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    margin: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: const Color.fromRGBO(233, 233, 233, 0.9),
                        borderRadius: BorderRadius.circular(10)),
                    child: const Text("女装111"),
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    margin: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: const Color.fromRGBO(233, 233, 233, 0.9),
                        borderRadius: BorderRadius.circular(10)),
                    child: const Text("女装"),
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    margin: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: const Color.fromRGBO(233, 233, 233, 0.9),
                        borderRadius: BorderRadius.circular(10)),
                    child: const Text("女装"),
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    margin: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: const Color.fromRGBO(233, 233, 233, 0.9),
                        borderRadius: BorderRadius.circular(10)),
                    child: const Text("女装"),
                  )
              ],
            ),
            const SizedBox(height: 10,),
            _historyListWidget()
          ],
        ),
      ),
    );
  }
}
