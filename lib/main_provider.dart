import 'package:flutter/material.dart';
import 'package:flutter_sample/provider/provider_demo_widget1.dart';
import 'package:flutter_sample/provider/provider_demo_widget2.dart';
import 'package:flutter_sample/provider/provider_demo_widget3.dart';
import 'package:flutter_sample/provider/provider_demo_widget4.dart';
import 'package:flutter_sample/provider/set_state_demo_widget.dart';
import 'package:provider/provider.dart';

import 'provider/post/list/post_list_widget.dart';

///
///Provider V3
///官方推荐库
///待优化
///
void main() => runApp(MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Provider"),
        ),
        body: MainProviderWidget(),
      ),
    ));

class MainProviderWidget extends StatefulWidget {
  @override
  _MainProviderWidgetState createState() => new _MainProviderWidgetState();
}

class _MainProviderWidgetState extends State<MainProviderWidget> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          _build(context, setStateDemoTitle, SetStateDemoWidget()),
          _build(context, providerDemoTitle1, ProviderDemoWidget1()),
          _build(context, providerDemoTitle2, ProviderDemoWidget2()),
          _build(context, providerDemoTitle3, ProviderDemoWidget3()),
          _build(context, providerDemoTitle4, ProviderDemoWidget4()),
          _build(context, "代码框架", PostListWidget()),
        ],
      ),
    );
  }

  Widget _build(BuildContext context, String text, Widget newRouteWidget) {
    return RaisedButton(
      child: Text(text),
      onPressed: () => Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => newRouteWidget,
      )),
    );
  }
}
