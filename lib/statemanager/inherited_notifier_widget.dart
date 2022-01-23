import 'package:flutter/material.dart';

///
///Provider V2
///实现了数据的共享/通知数据刷新
///待优化
/// 1.泛型实现
/// 2.不应该暴露ShareDataWidget，而是要ShareNotifierWidget 封装ShareDataWidget 获取数据
///
///

void main() => runApp(MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text("InheritedNotifierWidget"),
        ),
        body: InheritedNotifierWidget(),
      ),
    ));

class InheritedNotifierWidget extends StatefulWidget {
  const InheritedNotifierWidget({Key? key}) : super(key: key);

  @override
  _InheritedNotifierWidgetState createState() =>
      _InheritedNotifierWidgetState();
}

const String tag = "_InheritedNotifier";

class _InheritedNotifierWidgetState extends State<InheritedNotifierWidget> {
  final ShareModel _shareModel = new ShareModel(0);

  final ChangeNotifier _changeNotifier = new ChangeNotifier();

  @override
  Widget build(BuildContext context) {
    print("$tag build context:$context}");
    return Center(
      child: ShareNotifierWidget(
        notifier: _changeNotifier,
        model: _shareModel,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextWidget(),
            Builder(
              builder: (context2) {
                print("$tag _TestWidgetState build context:$context2");
                return Text(
                  ShareModelWidget.of(context2).model.count.toString(),
                  style: TextStyle(fontSize: 40),
                );
              },
            ),
            Builder(
              builder: (context2) {
                print("$tag _TestButtonState build context:$context2}");
                return ElevatedButton(
                    child: Text(
                        "Increment (current:${ShareModelWidget.of(context2).model.count.toString()})"),
                    onPressed: () {
                      ShareModelWidget.of(context2).model.increment();
                      ShareModelWidget.of(context2)
                          .notifier
                          .notifyListeners(); //与 setState区别？？
//                      setState(() {});
                    });
              },
            ),
          ],
        ),
      ),
    );
  }
}

class TextWidget extends StatefulWidget {
  @override
  _TextWidgetState createState() => _TextWidgetState();
}

class _TextWidgetState extends State<TextWidget> {
  @override
  Widget build(BuildContext context) {
    print("$tag TextWidget :BuildContext $context");
    var count = ShareModelWidget.of(context).model.count;
    return Text("计数:$count");
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print("$tag TextWidget :didChangeDependencies");
  }
}

class ShareModel with ChangeNotifier {
  int count;

  ShareModel(this.count);

  void increment() {
    count++;
  }
}

class ShareModelWidget extends InheritedWidget {
  ShareModelWidget(
      {required this.model, required this.notifier, required Widget child})
      : super(child: child);

  final ShareModel model; //需要在子树中共享的数据，保存点击次数

  final ChangeNotifier notifier;

  //定义一个便捷方法，方便子树中的widget获取共享数据
  static ShareModelWidget of(BuildContext context) {
//    return context.dependOnInheritedWidgetOfExactType<ShareModelWidget>();
    return (context
        .getElementForInheritedWidgetOfExactType<ShareModelWidget>()
        ?.widget) as ShareModelWidget;
  }

  //该回调决定当data发生变化时，是否通知子树中依赖data的Widget
  @override
  bool updateShouldNotify(ShareModelWidget old) {
    //如果返回true，则子树中依赖(build函数中有调用)本widget
    //的子widget的`state.didChangeDependencies`会被调用
//    return old.data != data;
    return true;
  }
}

class ShareNotifierWidget extends StatefulWidget {
  final ChangeNotifier notifier;

  final ShareModel model;

  final Widget child;

  ShareNotifierWidget({
    required this.notifier,
    required this.model,
    required this.child,
  });

  @override
  _ShareNotifierWidgetState createState() => _ShareNotifierWidgetState();
}

class _ShareNotifierWidgetState extends State<ShareNotifierWidget> {
  update() {
    setState(() {});
  }

  @override
  void initState() {
    widget.notifier.addListener(update);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("$tag TextWidget :didChangeDependencies");
    return ShareModelWidget(
      model: widget.model,
      notifier: widget.notifier,
      child: widget.child,
    );
  }

  @override
  void dispose() {
    super.dispose();
    widget.notifier.removeListener(update);
  }
}
