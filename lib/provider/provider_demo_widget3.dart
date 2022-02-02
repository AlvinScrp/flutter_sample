import 'package:flutter/material.dart';

const String providerDemoTitle3 = "Provider示例3";
const String providerDemoIntroduction3 = "上一个示例的通用泛型实现\n"
    "CountModel作为泛型实例，传递给ChangeNotifierProvider和Provider\n"
    "同时ChangeNotifierProvider和Provider也可以拿到别地用了";

class ProviderDemoWidget3 extends StatefulWidget {
  ProviderDemoWidget3({Key? key}) : super(key: key);

  @override
  _ProviderDemoWidget3State createState() => _ProviderDemoWidget3State();
}

class _ProviderDemoWidget3State extends State<ProviderDemoWidget3> {
  CountModel _countModel = CountModel(0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(providerDemoTitle3)),
      body: ChangeNotifierProvider<CountModel>(
        model: _countModel,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Builder(builder: (context1) {
                return Text("计数:${Provider.of<CountModel>(context1, true).count}（有依赖情况)");
              }),
              Builder(builder: (context2) {
                return Text("计数:${Provider.of<CountModel>(context2, false).count}（无依赖情况)");
              }),
              ElevatedButton(child: const Text("increment"), onPressed: () => _countModel.increment()),
              const Text(providerDemoIntroduction3),
            ],
          ),
        ),
      ),
    );
  }
}

class ChangeNotifierProvider<T extends ChangeNotifier> extends StatefulWidget {
  final Widget child;

  final T model;

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
    return Provider(
      model: widget.model,
      child: widget.child,
    );
  }
}

class Provider<T extends ChangeNotifier> extends InheritedWidget {
  final T model;

  Provider({Key? key, required this.model, required Widget child}) : super(key: key, child: child);

  static T of<T extends ChangeNotifier>(BuildContext context, bool depend) {
    var provider = depend
        ? context.dependOnInheritedWidgetOfExactType<Provider<ChangeNotifier>>()
        : context.getElementForInheritedWidgetOfExactType<Provider<ChangeNotifier>>()?.widget;
    return (provider as Provider<ChangeNotifier>).model as T;
  }

  @override
  bool updateShouldNotify(Provider old) {
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
