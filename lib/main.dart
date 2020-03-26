import 'package:flutter/material.dart';

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
  MyHomePage({Key key, this.title}) : super(key: key);
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
      body: Center(
          child: Container(
//              child: Column(
//        crossAxisAlignment: CrossAxisAlignment.stretch,
//        children: <Widget>[
//          new Text(
//            "在原生Android",
//            style: new TextStyle(
//              color: Color(0xFFFF0000),
//            ),
//          ),
//          new Text(
//            "文本的显示格式与式样对于网页设计师来说是一个重要问题。这一课将向你介绍CSS在文本布局方面令人激动的特性",
//            style: new TextStyle(
//              color: Color(0xFF000000),
//            ),
//          ),
//        ],
//      )
        child: Text.rich(TextSpan(text: "Q：", children: <TextSpan>[
          TextSpan(text: "文本的显示格式与式样对于网页设计师来说是一个重要问题。这一课将向你介绍CSS在文本布局方面令人激动的特性")
        ])),
      )),
    );
  }
}
