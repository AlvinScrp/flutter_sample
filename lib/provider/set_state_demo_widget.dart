import 'package:flutter/material.dart';

final String setStateDemoTitle = "setState示例";

class SetStateDemoWidget extends StatefulWidget {
  SetStateDemoWidget({Key key}) : super(key: key);

  @override
  _SetStateDemoWidgetState createState() => _SetStateDemoWidgetState();
}

class _SetStateDemoWidgetState extends State<SetStateDemoWidget> {
  int count = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(setStateDemoTitle),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("计数:$count"),
            RaisedButton(
              child: Text("increment"),
              onPressed: () => setState(() => count++),
            )
          ],
        ),
      ),
    );
  }
}
