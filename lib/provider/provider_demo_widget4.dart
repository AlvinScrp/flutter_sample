import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

const String providerDemoTitle4 = "Provider示例4";
const String providerDemoIntroduction4 = "\n\n"
    "使用第三方的Provider库。\n"
    "我们发现与上一个示例的简易版Provider上的使用方法是一致的。正如介绍所描述的非常简单。\n"
    "同时也补充一个Cosumer的使用\n"
    "当然了Provider库，可维护性，可测试性，可扩展性远比我们所写的强大。\n";

class ProviderDemoWidget4 extends StatefulWidget {
  ProviderDemoWidget4({Key? key}) : super(key: key);

  @override
  _ProviderDemoWidget4State createState() => _ProviderDemoWidget4State();
}

class _ProviderDemoWidget4State extends State<ProviderDemoWidget4> {
  CountModel _countModel = CountModel(0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(providerDemoTitle4),
      ),
      body: ChangeNotifierProvider.value(
        value: _countModel,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Consumer<CountModel>(
                builder: (contextC, model, child) {
                  return Text("计数:${model.count}（有依赖情况)");
                },
              ),
              Builder(builder: (context2) {
                return Text(
                    "计数:${Provider.of<CountModel>(context2, listen: false).count}（无依赖情况)");
              }),
              ElevatedButton(
                  child: Text("increment"),
                  onPressed: () => _countModel.increment()),
              Text(providerDemoIntroduction4),
            ],
          ),
        ),
      ),
    );
  }
}

class CountModel extends ChangeNotifier {
  int count;

  CountModel(this.count);

  void increment() {
    count++;
    notifyListeners();
  }
}
