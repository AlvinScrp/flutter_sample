import 'package:flutter/material.dart';

///
///Provider V1
///实现了数据的共享，通过手动调用 setState刷新页面
///待优化：
///  1.通知数据更新
///
void main() => runApp(MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("InheritedWidget"),
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
  ShareModel _shareModel = new ShareModel(0);
  @override
  Widget build(BuildContext context) {
    print("__TestButtonState build context:$context}");
    return Center(

      child: ShareModelWidget(
        //使用ShareDataWidget
        model: _shareModel,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Builder(builder: (context){
              print("__TestWidgetState build context:$context");
              return Text(ShareModelWidget.of(context).model.count.toString());
            },),
            Builder(builder: (context){
              print("__TestButtonState build context:$context}");
              return RaisedButton(
                child: Text(
                    "Increment (current:${ShareModelWidget.of(context).model.count.toString()})"),
                onPressed: () => ShareModelWidget.of(context).model.increment(),
              );
            },),
//            _TestText(),
//            _TestButton(),
            RaisedButton(
              child: Text("刷新页面"),
              onPressed: () => setState(() {}),
            ),
          ],
        ),
      ),
    );
  }
}


class _TestRefresh extends StatefulWidget {
  @override
  __TestRefreshState createState() => __TestRefreshState();
}

class __TestRefreshState extends State<_TestRefresh> {
  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      child: Text("刷新页面"),
      onPressed: () => setState(() {}),
    );
  }
}

class ShareModelWidget extends InheritedWidget {
  ShareModelWidget({@required this.model, Widget child}) : super(child: child);

  final ShareModel model; //需要在子树中共享的数据，保存点击次数

  //定义一个便捷方法，方便子树中的widget获取共享数据
  static ShareModelWidget of(BuildContext context) {
    return context.inheritFromWidgetOfExactType(ShareModelWidget);
//  return context.ancestorInheritedElementForWidgetOfExactType(ShareDataWidget).widget;
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

class ShareModel {
  int count;

  ShareModel(this.count);

  void increment() {
    count++;
  }
}
