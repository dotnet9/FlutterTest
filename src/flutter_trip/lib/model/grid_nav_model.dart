// 首页网格卡片模型
import 'package:flutter_trip/model/common_model.dart';

class GridNavModel {
  final GridNavItem? hotel;
  final GridNavItem? flight;
  final GridNavItem? travel;

  GridNavModel(
      {required this.hotel, required this.flight, required this.travel});

  factory GridNavModel.fromJson(Map<String, dynamic> json) {
    return GridNavModel(
        hotel:
            json['hotel'] != null ? GridNavItem.fromJson(json['hotel']) : null,
        flight: json['flight'] != null
            ? GridNavItem.fromJson(json['flight'])
            : null,
        travel: json['travel'] != null
            ? GridNavItem.fromJson(json['travel'])
            : null);
  }

  Map<String, dynamic> toJson() {
    return {
      'hotel': hotel?.toJson(),
      'flight': flight?.toJson(),
      'travel': travel?.toJson(),
    };
  }
}

class GridNavItem {
  final String startColor;
  final String endColor;
  final CommonModel? mainItem;
  final CommonModel? item1;
  final CommonModel? item2;
  final CommonModel? item3;
  final CommonModel? item4;

  GridNavItem(
      {required this.startColor,
      required this.endColor,
      required this.mainItem,
      required this.item1,
      required this.item2,
      required this.item3,
      required this.item4});

  factory GridNavItem.fromJson(Map<String, dynamic> json) {
    return GridNavItem(
      startColor: json['startColor'],
      endColor: json['endColor'],
      mainItem: json['mainItem'] != null
          ? CommonModel.fromJson(json['mainItem'])
          : null,
      item1: json['item1'] != null ? CommonModel.fromJson(json['item1']) : null,
      item2: json['item2'] != null ? CommonModel.fromJson(json['item2']) : null,
      item3: json['item3'] != null ? CommonModel.fromJson(json['item3']) : null,
      item4: json['item4'] != null ? CommonModel.fromJson(json['item4']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'startColor': startColor,
      'endColor': endColor,
      'mainItem': mainItem?.toJson(),
      'item1': item1?.toJson(),
      'item2': item2?.toJson(),
      'item3': item3?.toJson(),
      'item4': item4?.toJson(),
    };
  }
}
