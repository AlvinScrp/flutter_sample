import 'package:flutter/material.dart';

import 'eventbus/eventbus_demo_widget1.dart';
import 'eventbus/eventbus_demo_widget2.dart';

void main() => runApp(MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text("EventBus"),
        ),
        body:  MainEventBusWidget(),
      ),
    ));

class MainEventBusWidget extends StatefulWidget {
  const MainEventBusWidget({Key? key}) : super(key: key);

  @override
  _MainEventBusWidgetState createState() => _MainEventBusWidgetState();
}

class _MainEventBusWidgetState extends State<MainEventBusWidget> {
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
    return ElevatedButton(
      child: Text(text),
      onPressed: () => Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => newRouteWidget,
      )),
    );
  }
}
