import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class WebView extends StatefulWidget {
  final String? url;
  final String? statusBarColor;
  final String? title;
  final bool? hideAppBar;
  final bool? backForbid;

  WebView(
      {this.url,
      this.statusBarColor,
      this.title,
      this.hideAppBar,
      this.backForbid});

  @override
  _WebViewState createState() => _WebViewState();
}

class _WebViewState extends State<WebView> {
  final webviewReference = FlutterWebviewPlugin();
  late StreamSubscription<String> _onUrlChanged;
  StreamSubscription<WebViewStateChanged> _onStateChanged;
  Stream<WebViewHttpError> _onHttpError;

  @override
  void initState() {
    super.initState();
    webviewReference.close();
    _onUrlChanged =
        webviewReference.onUrlChanged.listen((WebViewStateChanged state) {
      switch (state.type) {
        case _WebViewState.startLoad:
          break;
        default:
          break;
      }
    });

    _onHttpError = webviewReference
  }

  @override
  void dispose() {
    super.dispose();
    _onUrlChanged.cancel();
    webviewReference.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return null;
  }
}