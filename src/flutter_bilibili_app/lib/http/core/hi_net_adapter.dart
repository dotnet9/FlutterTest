// 网络请求抽象类
import 'package:flutter_bilibili_app/http/request/base_request.dart';

abstract class HiNetAdapter {
  Future<HiNetResponse<T>> send<T>(BaseRequest request);
}

class HiNetResponse<T> {
  HiNetResponse({
    this.data,
    this.request,
    this.statusCode,
    this.statusMessage,
    this.extra,
  });

  // Response body. may have been transformed, please refer to [ResponseType].
  T data;

  // The corresponding request info.
  BaseRequest request;

  // Http status code.
  int statusCode;

  // Returns the reason phrase associated with the status code.
  // The reason phrase must be set before the body is written
  String statusMessage;

  String extra;
}
