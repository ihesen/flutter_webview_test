import 'package:flutter/material.dart';
import 'package:flutter_webview_test/webview_flutter/webview_flutter_main.dart';

import 'flutter_webview_plugin/flutter_webview_plugin_main.dart';

class HomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("flutter webview"),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            RightView(
              title: "flutter webview plugin",
              rightClick: () {
                print("flutter webview plugin");
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return FlutterWebviewPluginMain();
                }));
              },
            ),
            RightView(
              title: "webview flutter",
              rightClick: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return WebViewFlutterMain();
                }));
              },
            )
          ],
        ),
      ),
    );
  }

  void goToPage() {}
}

class RightView extends StatelessWidget {
  String title;
  VoidCallback rightClick;

  RightView({this.title, this.rightClick});

  @override
  Widget build(BuildContext context) {
    var containView;
    if (title != Null) {
      containView = new Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(10.0),
        child: GestureDetector(
          child: Text(
            this.title,
            style: TextStyle(color: Colors.black, fontSize: 18.0),
          ),
          onTap: this.rightClick,
        ),
      );
    } else {
      containView = Text("");
    }
    return containView;
  }
}
