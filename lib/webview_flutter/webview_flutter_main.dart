import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../home_page.dart';

class WebViewFlutterMain extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new Scaffold(
        appBar: new AppBar(
          title: Text("Webview Flutter"),
        ),
        body: new Container(
          child: new WebViewExample(),
        ),
      ),
    );
    ;
  }
}

class WebViewExample extends StatefulWidget {
  @override
  _WebViewExampleState createState() => _WebViewExampleState();
}

WebViewController _webViewController;

final Set<JavascriptChannel> jsChannels = [
  JavascriptChannel(
      // js 通信 bridge 对象，注意定义名称需要满足，正则要求
      name: 'FlutterJsBridge',
      onMessageReceived: (JavascriptMessage message) {
        print('flutter 接收到 js 参数：' + message.message);
        _webViewController
            .evaluateJavascript("flutterInvokeJs('flutter invoke js')");
      }),
].toSet();

class _WebViewExampleState extends State<WebViewExample> {
  var localUrl = HomePage.unameController.text;

  final Completer<WebViewController> _controller =
      Completer<WebViewController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(builder: (BuildContext context) {
        return WebView(
          initialUrl: localUrl,
          javascriptMode: JavascriptMode.unrestricted,
          onWebViewCreated: (WebViewController webViewController) {
            _webViewController = webViewController;
            _controller.complete(webViewController);
          },
          javascriptChannels: jsChannels,
          navigationDelegate: (NavigationRequest request) {
            print('allowing navigation to $request');
            return NavigationDecision.navigate;
          },
          onPageStarted: (String url) {
            print('Page started loading: $url');
          },
          onPageFinished: (String url) {
            print('Page finished loading: $url');
          },
          gestureNavigationEnabled: true,
        );
      }),
    );
  }
}
