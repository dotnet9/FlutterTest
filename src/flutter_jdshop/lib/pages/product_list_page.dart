import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_jdshop/config/config.dart';
import 'package:flutter_jdshop/model/product_model.dart';
import 'package:flutter_jdshop/services/screen_adapter.dart';
import 'package:flutter_jdshop/widget/loading_widget.dart';

class ProductListPage extends StatefulWidget {
  Map? arguments;
  ProductListPage({Key? key, this.arguments}) : super(key: key);

  @override
  _ProductListPageState createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  // Scaffold key
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  // 用于上位分页 listview的控制器
  ScrollController _scrollController = ScrollController();
  // 分页索引
  int _page = 1;
  // 分页大小
  int _pageSize = 8;
  // 每页数据
  List _productList = [];
  /*
   * 排序:
   * 价格升序 sort=price_1
   * 价格降序 sort=price_-1
   * 销量升序 sort=salecount_1
   * 销量降序 sort=salecount_-1
   */
  String _sort = '';
  // 解决请求的问题
  bool _flag = true;
  // 是否还有数据
  bool _hasMore = true;
  // 分类或者搜索关键词下面是否有数据
  bool _hasData = true;
  // 二级导航数据
  final List _subHeaderList = [
    SubHeaderItem(1, '综合', 'all',
        -1), //排序     升序：price_1     {price:1}        降序：price_-1   {price:-1}
    SubHeaderItem(2, '销量', 'salecount', -1),
    SubHeaderItem(3, '价格', 'price', -1),
    SubHeaderItem(4, '筛选', '', -1)
  ];
  // 二级导航选中判断
  int _selectHeaderId = 1;

  // 配置search搜索框的值
  var _initKeywordsController = TextEditingController();
  // 分类id 如果指定类型的话注意可空 String? _cid
  String? _cid;
  // 搜索关键词 如果指定类型的话注意可空 String? _keywords
  String? _keywords;

  @override
  void initState() {
    super.initState();

    _cid = widget.arguments?['cid'];
    _keywords = widget.arguments?['keywords'];

    // 给search框赋值
    if (_keywords != null) {
      _initKeywordsController.text = _keywords ?? '';
    }
    _getProductListData();

    // 监听滚动条滚动事件
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >
          _scrollController.position.maxScrollExtent - 20) {
        if (_flag && _hasMore) {
          _getProductListData();
        }
      }
    });
  }

  // 获取商品列表的数据
  _getProductListData() async {
    setState(() {
      _flag = false;
    });
    String api;
    if (_keywords == null) {
      api =
          '${Config.domain}api/plist?cid=$_cid&page=$_page&sort=$_sort&pageSize=$_pageSize';
    } else {
      api =
          '${Config.domain}api/plist?search=$_keywords&page=$_page&sort=$_sort&pageSize=$_pageSize';
    }
    var result = await Dio().get(api);
    var productList = ProductModel.fromJson(result.data);

    // 判断是否有搜索数据
    if (productList.result.length == 0 && _page == 1) {
      setState(() {
        _hasData = false;
      });
    } else {
      setState(() {
        _hasData = true;
      });
    }

    //判断最后一页有没有数据
    if (productList.result.length < _pageSize) {
      setState(() {
        _productList.addAll(productList.result);
        _hasMore = false;
        _flag = true;
      });
    } else {
      setState(() {
        _productList.addAll(productList.result);
        _page++;
        _flag = true;
      });
    }
  }

  // 显示加载中的圈圈
  Widget _showMore(index) {
    if (_hasMore) {
      return (index == _productList.length - 1)
          ? const LoadingWidget()
          : const Text('');
    } else {
      return (index == _productList.length - 1)
          ? const Text('--我是有底线的--')
          : const Text('');
    }
  }

  Widget _productListWidget() {
    if (_productList.isNotEmpty) {
      return Container(
        padding: const EdgeInsets.all(10),
        margin: EdgeInsets.only(top: ScreenAdapter.height(80)),
        child: ListView.builder(
          controller: _scrollController,
          itemBuilder: (context, index) {
            String pic = _productList[index].pic;
            pic = Config.domain + pic.replaceAll('\\', '/');
            return Column(
              children: [
                Row(
                  children: [
                    SizedBox(
                      width: ScreenAdapter.width(180),
                      height: ScreenAdapter.height(180),
                      child: Image.network(pic, fit: BoxFit.cover),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        height: ScreenAdapter.height(180),
                        margin: const EdgeInsets.only(left: 10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              _productList[index].title,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Row(
                              children: [
                                Container(
                                  height: ScreenAdapter.height(36),
                                  margin: const EdgeInsets.only(right: 10),
                                  padding:
                                      const EdgeInsets.fromLTRB(10, 0, 10, 0),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: const Color.fromRGBO(
                                          230, 230, 230, 0.9)),
                                  child: const Text('4G'),
                                ),
                                Container(
                                  height: ScreenAdapter.height(36),
                                  margin: const EdgeInsets.only(right: 10),
                                  padding:
                                      const EdgeInsets.fromLTRB(10, 0, 10, 0),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: const Color.fromRGBO(
                                          230, 230, 230, 0.9)),
                                  child: const Text('126'),
                                )
                              ],
                            ),
                            Text(
                              '￥${_productList[index].price}',
                              style: const TextStyle(
                                  color: Colors.red, fontSize: 16),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
                const Divider(height: 20),
                _showMore(index)
              ],
            );
          },
          itemCount: _productList.length,
        ),
      );
    } else {
      return const LoadingWidget();
    }
  }

  // 导航改变的时候触发
  _subHeaderChange(id) {
    if (id == 4) {
      _scaffoldKey.currentState!.openEndDrawer();
      setState(() {
        _selectHeaderId = id;
      });

      return;
    }

    setState(() {
      _selectHeaderId = id;
      _sort = '${_subHeaderList[id - 1].fields}_${_subHeaderList[id - 1].sort}';

      _page = 1;
      _productList = [];
      _subHeaderList[id - 1].sort = _subHeaderList[id - 1].sort * -1;
      _scrollController.jumpTo(0);
      _hasMore = true;
      _getProductListData();
    });
  }

  // 显示header Icon
  Widget _showIcon(id) {
    if (id == 2 || id == 3) {
      if (_subHeaderList[id - 1].sort == 1) {
        return const Icon(Icons.arrow_drop_down);
      }
      return const Icon(Icons.arrow_drop_up);
    }
    return const Text('');
  }

  // 筛选导航
  Widget _subHeaderWidget() {
    return Positioned(
        top: 0,
        height: ScreenAdapter.height(80),
        width: ScreenAdapter.width(750),
        child: Container(
          width: ScreenAdapter.width(750),
          height: ScreenAdapter.height(80),
          decoration: const BoxDecoration(
              border: Border(
                  bottom: BorderSide(
                      width: 1, color: Color.fromRGBO(233, 233, 233, 0.9)))),
          child: Row(
            children: _subHeaderList.map((value) {
              return Expanded(
                flex: 1,
                child: InkWell(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(0, ScreenAdapter.height(16), 0,
                        ScreenAdapter.height(16)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          value.title,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: (_selectHeaderId == value.id)
                                ? Colors.red
                                : Colors.black54,
                          ),
                        ),
                        _showIcon(value.id)
                      ],
                    ),
                  ),
                  onTap: () {
                    _subHeaderChange(value.id);
                  },
                ),
              );
            }).toList(),
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back)),
          title: Container(
            child: TextField(
              controller: _initKeywordsController,
              autofocus: false,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide.none)),
              onChanged: (value) {
                setState(() {
                  _keywords = value;
                });
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
                  children: const [ 
                    Text('搜索')
                  ],
                ),
              ),
              onTap: () {
                _subHeaderChange(1);
              },
            )
          ],
        ),
        endDrawer: Drawer(
          child: Container(
            child: const Text('实现筛选功能'),
          ),
        ),
        body: _hasData ? Stack(
          children: [
            _productListWidget(),
            _subHeaderWidget(),
          ],
        ) : const Center(child: Text('没有您要浏览的数据'),));
  }
}

class SubHeaderItem {
  int id;
  String title;
  String fields;
  int sort;

  SubHeaderItem(this.id, this.title, this.fields, this.sort);
}
