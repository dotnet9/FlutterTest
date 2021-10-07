import 'dart:convert';
import 'package:flutter_jdshop/services/storage.dart';

class SearchServices {
  static const String _key = 'searchList';
  static setHistoryData(keywords) async {
    String? searchList = await Storage.getString(_key);
    if (searchList != null) {
      List searchListData = json.decode(searchList);
      var hasData = searchListData.any((element) => element == keywords);
      if (!hasData) {
        searchListData.add(keywords);
        await Storage.setString(_key, json.encode(searchListData));
      } else {
        List tempList = [];
        tempList.add(keywords);
        await Storage.setString(_key, json.encode(tempList));
      }
    }
  }

  static getHistoryList() async {
    String? searchList = await Storage.getString(_key);
    if (searchList != null) {
      List searchListData = json.decode(searchList);
      return searchListData;
    }

    return [];
  }

  static clearHistoryList() async {
    await Storage.remove(_key);
  }

  static removeHistoryData(keywords) async {
    String? searchList = await Storage.getString(_key);
    if (searchList != null) {
      List searchListData = json.decode(searchList);
      searchListData.remove(keywords);
      await Storage.setString(_key, json.encode(searchListData));
    }
  }
}
