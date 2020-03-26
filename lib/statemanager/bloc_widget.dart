import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:provider/provider.dart';
import 'package:redux/redux.dart';

///
///
void main() => runApp(MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("BLocWidget"),
        ),
        body: BLocWidget(),
      ),
    ));

class BLocWidget extends StatefulWidget {
  @override
  _BLocWidgetState createState() => new _BLocWidgetState();
}

class _BLocWidgetState extends State<BLocWidget> {
  final _bloc = ShareBLoC();

  @override
  Widget build(BuildContext context) {
    print("_BLocWidget build context:$context}");
    return Center(
        child: ShareProvider(
      shareBloc: _bloc,
      child: StreamBuilder<int>(
          stream: _bloc.stream,
          initialData: 0,
          builder: (context2, snapshot) {
            return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "${snapshot.data}",
                    style: TextStyle(fontSize: 40),
                  ),
                  RaisedButton(
                      child: Text("Increment (current:${snapshot.data})"),
                      onPressed: () {
                        ShareProvider.of(context2).increment();
//                        _bloc.increment();
                      }),
                ]);
          }),
    ));
  }
}

class ShareBLoC {
  int _count;
  StreamController<int> _countController;

  ShareBLoC() {
    _count = 0;
    _countController = StreamController<int>();
  }

  Stream<int> get stream => _countController.stream;

  increment() {
    _countController.sink.add(++_count);
  }

  dispose() {
    _countController.close();
  }
}

class ShareProvider extends InheritedWidget {
  final ShareBLoC shareBloc;

  ShareProvider({
    Key key,
    ShareBLoC shareBloc,
    Widget child,
  })  : shareBloc = shareBloc ?? ShareBLoC(),
        super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  static ShareBLoC of(BuildContext context) =>
      (context.inheritFromWidgetOfExactType(ShareProvider) as ShareProvider)
          .shareBloc;
}
