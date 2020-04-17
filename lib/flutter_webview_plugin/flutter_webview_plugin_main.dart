import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class FlutterWebviewPluginMain extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return FlutterWebviewPluginMainState();
  }
}

class FlutterWebviewPluginMainState extends State {
  var loadUrl = "http://www.baidu.com";

  final flutterWebviewPlugin = new FlutterWebviewPlugin();

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
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return new WebviewScaffold(
        url: loadUrl,
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
