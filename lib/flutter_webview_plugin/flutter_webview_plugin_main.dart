import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:flutter_webview_test/home_page.dart';

class FlutterWebviewPluginMain extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return FlutterWebviewPluginMainState();
  }
}
final flutterWebviewPlugin = new FlutterWebviewPlugin();

final Set<JavascriptChannel> jsChannels = [
  JavascriptChannel(
      // js 通信 bridge 对象，注意定义名称需要满足，正则要求
      name: 'FlutterJsBridge',
      onMessageReceived: (JavascriptMessage message) {
        print('flutter 接收到 js 参数：' + message.message);
        flutterWebviewPlugin.evalJavascript("flutterInvokeJs('flutter invoke js')");
      }),
].toSet();


class FlutterWebviewPluginMainState extends State {

  var loadUrl = HomePage.unameController.text;

  // On urlChanged stream
  StreamSubscription<String> _onUrlChanged;

  @override
  void initState() {
    super.initState();

    _onUrlChanged = flutterWebviewPlugin.onUrlChanged.listen((String url) {
//      if (mounted) {
//        setState(() {
//          print('onUrlChanged url : $url');
//        });
//      }
      print('onUrlChanged url : $url');
    });

    //网页的加载监听（loading,start,finish可以去查看源码），包括重定向
    flutterWebviewPlugin.onStateChanged.listen((WebViewStateChanged state) {
      print('onStateChanged state type:' +
          state.type.toString() +
          " url: ${state.url} navigationType :  ${state.navigationType}");
    });
  }

  @override
  Widget build(BuildContext context) {
    return new WebviewScaffold(
        url: loadUrl,
        //定义js和flutter通信channel
        javascriptChannels: jsChannels,
        appBar: new AppBar(
          title: new Text("Widget webview"),
        ));
  }

  @override
  void dispose() {
    _onUrlChanged.cancel();
    super.dispose();
  }
}
