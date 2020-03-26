
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

///
///Provider V3
///官方推荐库
///待优化
/// 1.泛型实现
/// 2.不应该暴露ShareDataWidget，而是要ShareNotifierWidget 封装ShareDataWidget 获取数据
///
void main() => runApp(MaterialApp(
  home: Scaffold(
    appBar: AppBar(
      title: Text("ProviderWidget"),
    ),
    body: InheritedWidgetTestRoute(),
  ),
));

class InheritedWidgetTestRoute extends StatefulWidget {
  @override
  _InheritedWidgetTestRouteState createState() =>
      new _InheritedWidgetTestRouteState();
}

class _InheritedWidgetTestRouteState extends State<InheritedWidgetTestRoute> {
  ShareModelWithNotifier _shareDataWithNotifier = new ShareModelWithNotifier(0);

  @override
  Widget build(BuildContext context) {

    print("_ProviderWidget build context:$context}");
    return Center(
      child: ChangeNotifierProvider<ShareModelWithNotifier>.value(
        value: _shareDataWithNotifier,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Consumer<ShareModelWithNotifier>(
              builder:  (context2,model,child){
                print("__TestWidgetState build context:$context2");
                return Text(
                  model.count.toString(),
                  style: TextStyle(fontSize: 40),
                );
              },
            ),

            Builder(
              builder: (context2) {
                print("__TestButtonState build context:$context2}");
                return RaisedButton(
                    child: Text(
                        "Increment (current:${Provider.of<ShareModelWithNotifier>(context2,listen: true)?.count.toString()})"),
//                    "Increment (current)"),
                    onPressed: () {
                      Provider.of<ShareModelWithNotifier>(context2,listen: true).increment();
                    });
              },
            ),
          ],
        ),
      ),
    );
  }
}

class ShareModelWithNotifier with ChangeNotifier {
  int count;

  ShareModelWithNotifier(this.count);

  void increment() {
    count++;
    notifyListeners();
  }
}


