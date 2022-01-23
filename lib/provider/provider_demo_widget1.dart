import 'package:flutter/material.dart';

const String providerDemoTitle1 = "Provider示例1";
const String providerDemoIntroduction1 =
    "\n\n用InheritedWidget保存数据\n以及访问InheritedWidget拿到数据";

class ProviderDemoWidget1 extends StatefulWidget {
  const ProviderDemoWidget1({Key? key}) : super(key: key);

  @override
  _ProviderDemoWidget1State createState() => _ProviderDemoWidget1State();
}

class _ProviderDemoWidget1State extends State<ProviderDemoWidget1> {
  int _count = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(providerDemoTitle1),
      ),
      body: CountProvider(
        count: _count,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Builder(
                builder: (context2) {
                  CountProvider provider = (context2
                      .getElementForInheritedWidgetOfExactType<CountProvider>()
                      ?.widget) as CountProvider;
                  return Text("计数:${provider.count}");
                },
              ),

              /// 读取和显示计数
              ElevatedButton(
                child: const Text("increment"),
                onPressed: () => setState(() => _count++),
              ),
              const Text(providerDemoIntroduction1),
            ],
          ),
        ),
      ),
    );
  }
}

class CountProvider extends InheritedWidget {
  final int count;

  const CountProvider({Key? key, required this.count, required Widget child})
      : super(key: key, child: child);

  @override
  bool updateShouldNotify(CountProvider old) {
    return true;
  }
}
