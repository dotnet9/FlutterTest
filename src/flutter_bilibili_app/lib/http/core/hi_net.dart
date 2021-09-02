import 'dart:ffi';

import 'package:flutter_bilibili_app/http/request/base_request.dart';

class HiNet {
  HiNet._();

  static HiNet? _instance;
  static HiNet get instance => _instance ??= HiNet._();

  Future fire(BaseRequest request) async {
    var response = await send(request);
    var result = response['data'];
    printLog(result);
    return result;
  }

  Future<dynamic> send<T>(BaseRequest request) async {
    printLog('url: ${request.url()}');
    printLog('method: ${request.httpMethod()}');
    request.addHeader('token', '123');
    printLog('header: ${request.header}');
    return Future.value({
      'statusCode': 200,
      'data': {'code': 0, 'message': 'success'}
    });
  }

  void printLog(log) {
    print('hi_net: ${log.toString()}');
  }
}
