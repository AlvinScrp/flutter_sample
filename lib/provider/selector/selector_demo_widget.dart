import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SelectorDemoWidget extends StatefulWidget {
  SelectorDemoWidget({Key? key}) : super(key: key);

  @override
  _SelectorDemoWidgetState createState() => _SelectorDemoWidgetState();
}

class _SelectorDemoWidgetState extends State<SelectorDemoWidget> {
  CountModel _model = CountModel()..initData();

  @override
  void initState() {
    super.initState();
    _model = CountModel()..initData();
  }

  @override
  Widget build(BuildContext context) {
    List<CountItemWidget> _children = _model.contentMap.keys
        .map((key) => CountItemWidget(content: key))
        .toList();
    return Scaffold(
        appBar: AppBar(
          title: Text("Selector示例"),
        ),
        body: ChangeNotifierProvider.value(
          value: _model,
          child: ListView(children: _children),
        ));
  }
}

class CountItemWidget extends StatelessWidget {
  final String content;

  CountItemWidget({required this.content});

  @override
  Widget build(BuildContext context) {
    print("CountItemWidget:build");
    return Container(
      height: 80,
      padding: EdgeInsets.all(15),
      alignment: Alignment.center,
      child: ElevatedButton(
        onPressed: () =>
            Provider.of<CountModel>(context, listen: false).increment(content),
        child: Selector<CountModel, int>(
            selector: (context, model) => model.contentMap[content]!,
            shouldRebuild: (preCount, nextCount) => preCount != nextCount,
            builder: (context, count, child) {
              print("$content Selector:builder");
              return Text("$content : $count");
            }),
      ),
    );
  }
}

class CountModel extends ChangeNotifier {
  Map<String, int> contentMap = SplayTreeMap();

  initData() {
    contentMap["a"] = 0;
    contentMap["b"] = 0;
    contentMap["c"] = 0;
  }

  increment(String content) {
    if (contentMap.containsKey(content)) {
      contentMap[content] = contentMap[content]! + 1;
      notifyListeners();
    }
  }
}
