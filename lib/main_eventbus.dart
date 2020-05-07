import 'package:flutter/material.dart';
import 'package:flutter_sample/provider/provider_demo_widget1.dart';
import 'package:flutter_sample/provider/provider_demo_widget2.dart';
import 'package:flutter_sample/provider/provider_demo_widget3.dart';
import 'package:flutter_sample/provider/provider_demo_widget4.dart';
import 'package:flutter_sample/provider/selector/selector_demo_widget.dart';
import 'package:flutter_sample/provider/set_state_demo_widget.dart';
import 'package:provider/provider.dart';

import 'eventbus/eventbus_demo_widget1.dart';
import 'eventbus/eventbus_demo_widget2.dart';
import 'provider/post/list/post_list_widget.dart';

void main() => runApp(MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("EventBus"),
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
          _build(context, eventBusDemo1Title, EventBusDemoWidget1()),
          _build(context, eventBusDemo2Title, EventBusDemoWidget2()),
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
