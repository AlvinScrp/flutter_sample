import 'package:flutter/material.dart';

import 'provider/post/list/post_list_widget.dart';
import 'provider/provider_demo_widget1.dart';
import 'provider/provider_demo_widget2.dart';
import 'provider/provider_demo_widget3.dart';
import 'provider/provider_demo_widget4.dart';
import 'provider/selector/selector_demo_widget.dart';
import 'provider/set_state_demo_widget.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Column(
          children: [
            _build(context, setStateDemoTitle, SetStateDemoWidget()),
            _build(context, providerDemoTitle1, const ProviderDemoWidget1()),
            _build(context, providerDemoTitle2, ProviderDemoWidget2()),
            _build(context, providerDemoTitle3, ProviderDemoWidget3()),
            _build(context, providerDemoTitle4, ProviderDemoWidget4()),
            _build(context, "代码应用(简易社区)", PostListWidget()),
            _build(context, "Selector使用", SelectorDemoWidget()),
          ],
        ));
  }

  Widget _build(BuildContext context, String text, Widget newRouteWidget) {
    return ElevatedButton(
      child: Text(text),
      onPressed: () => Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => newRouteWidget,
      )),
    );
  }
}
