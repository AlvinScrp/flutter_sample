import 'package:flutter/material.dart';
import 'package:flutter_sample/statemanager/redux_widget.dart';

final String providerDemoTitle1 = "Provider示例1";
final String providerDemoIntroduction1 =
    "\n\n用InheritedWidget保存数据\n以及访问InheritedWidget拿到数据";

class ProviderDemoWidget1 extends StatefulWidget {
  ProviderDemoWidget1({Key key}) : super(key: key);

  @override
  _ProviderDemoWidget1State createState() => _ProviderDemoWidget1State();
}

class _ProviderDemoWidget1State extends State<ProviderDemoWidget1> {
  int _count = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(providerDemoTitle1),
      ),
      body: CountProvider(
        count: _count,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Builder(
                builder: (context2) {
                  CountProvider provider = context2
                      .getElementForInheritedWidgetOfExactType<CountProvider>()
                      .widget;
                  return Text("计数:${provider.count}");
                },
              ),

              /// 读取和显示计数
              RaisedButton(
                child: Text("increment"),
                onPressed: () => setState(() => _count++),
              ),
              Text(providerDemoIntroduction1),
            ],
          ),
        ),
      ),
    );
  }
}

class CountProvider extends InheritedWidget {
  final int count;

  CountProvider({Key key, this.count, Widget child})
      : super(key: key, child: child);

  @override
  bool updateShouldNotify(CountProvider old) {
    return true;
  }
}
