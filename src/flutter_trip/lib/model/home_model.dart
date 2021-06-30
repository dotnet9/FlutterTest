import 'package:flutter_trip/model/common_model.dart';
import 'package:flutter_trip/model/config_model.dart';
import 'package:flutter_trip/model/grid_nav_model.dart';
import 'package:flutter_trip/model/sales_box_model.dart';

class HomeModel {
  final ConfigModel config;
  final List<CommonModel> bannerList;
  final List<CommonModel> localNavList;
  final List<CommonModel> subNavList;
  final GridNavModel gridNav;
  final SalesBoxModel salesBox;

  HomeModel(
      {required this.config,
      required this.bannerList,
      required this.localNavList,
      required this.subNavList,
      required this.gridNav,
      required this.salesBox});

  factory HomeModel.fromJson(Map<String, dynamic> json) {
    var bannerListJson = json['bannerList'] as List;
    List<CommonModel> bannerList =
        bannerListJson.map((i) => CommonModel.fromJson(i)).toList();

    var localNavListJson = json['localNavList'] as List;
    List<CommonModel> localNavList =
        localNavListJson.map((i) => CommonModel.fromJson(i)).toList();

    var subNavListJson = json['subNavList'] as List;
    List<CommonModel> subNavList =
        subNavListJson.map((i) => CommonModel.fromJson(i)).toList();

    return HomeModel(
        config: ConfigModel.fromJson(json['config']),
        bannerList: bannerList,
        localNavList: localNavList,
        subNavList: subNavList,
        gridNav: GridNavModel.fromJson(json['gridNav']),
        salesBox: SalesBoxModel.fromJson(json['salesBox']));
  }

  Map<String, dynamic> toJson() {
    return {
      'config': config.toJson(),
      'bannerList': bannerList.map((e) => e.toJson()).toList(),
      'localNavList': localNavList.map((e) => e.toJson()).toList(),
      'subNavList': subNavList.map((e) => e.toJson()).toList(),
      'gridNav': gridNav.toJson(),
      'salesBox': salesBox.toJson(),
    };
  }
}
