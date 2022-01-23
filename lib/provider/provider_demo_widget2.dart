import 'package:flutter/material.dart';

const String providerDemoTitle2 = "Provider示例2";
const String providerDemoIntroduction2 = "\n\n\n\n\n\n\n\n\n\n\n\n\n\n"
    "* 完善InheritedWidget功能\n"
    "* Provider继承InheritedWidget,强化其访问功能\n"
    "* CountModel封装示例1中的count，继承ChangeNotifier，具备notify能力\n"
    "* ChangeNotifierProvider通过监听ChangeNotifier，将setState封装在其内部\n"
    "* 总之，把状态管理(数据修改和Widget刷新)封装在自定义的对象内。"
    "外部控件不需要再关心状态管理的细节了\n";

class ProviderDemoWidget2 extends StatefulWidget {
  ProviderDemoWidget2({Key? key}) : super(key: key);

  @override
  _ProviderDemoWidget2State createState() => _ProviderDemoWidget2State();
}

class _ProviderDemoWidget2State extends State<ProviderDemoWidget2> {
  CountModel _countModel = CountModel(0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(providerDemoTitle2),
      ),
      body: ChangeNotifierProvider(
        model: _countModel,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Builder(builder: (context1) {
                return Text("计数:${_countModel.count}");
              }),
              Builder(builder: (context1) {
                return Text(
                    "计数:${CountProvider.of(context1, true).count}（有依赖情况)");
              }),
              Builder(builder: (context2) {
                return Text(
                    "计数:${CountProvider.of(context2, false).count}（无依赖情况)");
              }),
              ElevatedButton(
                  child: const Text("increment"),
                  onPressed: () => _countModel.increment()),
              const Text(providerDemoIntroduction2),
            ],
          ),
        ),
      ),
    );
  }
}

class ChangeNotifierProvider extends StatefulWidget {
  final Widget child;

  final CountModel model;

  ChangeNotifierProvider({Key? key, required this.child, required this.model}) : super(key: key);

  @override
  _ChangeNotifierProviderState createState() => _ChangeNotifierProviderState();
}

class _ChangeNotifierProviderState extends State<ChangeNotifierProvider> {
  _ChangeNotifierProviderState();

  _update() {
    setState(() => {});
  }

  @override
  void initState() {
    super.initState();
    widget.model.addListener(_update);
  }

  @override
  void dispose() {
    super.dispose();
    widget.model.removeListener(_update);
  }

  @override
  Widget build(BuildContext context) {
    return CountProvider(
      model: widget.model,
      child: widget.child,
    );
  }
}

class CountProvider extends InheritedWidget {
  final CountModel model;

  CountProvider({Key? key, required this.model, required Widget child})
      : super(key: key, child: child);

  static CountModel of(BuildContext context, bool depend) {
    if (depend) {
      return (context.dependOnInheritedWidgetOfExactType(aspect: CountProvider)
              as CountProvider)
          .model;
    } else {
      CountProvider provider = (context
          .getElementForInheritedWidgetOfExactType<CountProvider>()
          ?.widget) as CountProvider;
      return provider.model;
    }
  }

  @override
  bool updateShouldNotify(CountProvider old) {
    return true;
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
