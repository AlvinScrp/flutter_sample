import 'dart:async';

import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

///
///
void main() => runApp(MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("BLocRxDartWidget"),
        ),
        body: BLocRxDartWidget(),
      ),
    ));

class BLocRxDartWidget extends StatefulWidget {
  @override
  _BLocRxDartWidgetState createState() => new _BLocRxDartWidgetState();
}

class _BLocRxDartWidgetState extends State<BLocRxDartWidget> {
  final _bloc = ShareBLoC();

  @override
  Widget build(BuildContext context) {
    print("_BLocWidget build context:$context}");
    return Center(
        child: ShareProvider(
      shareBloc: _bloc,
      child: StreamBuilder<int>(
          stream: _bloc._countStream,
          initialData: 0,
          builder: (context2, snapshot) {
            return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "${snapshot.data}",
                    style: TextStyle(fontSize: 40),
                  ),
                  ElevatedButton(
                      child: Text("Increment (current:${snapshot.data})"),
                      onPressed: () {
                        ShareProvider.of(context2).increment();
                      }),
                ]);
          }),
    ));
  }
}

class ShareBLoC {
  int _count = 0;

  final BehaviorSubject<int> _countSubject = BehaviorSubject<int>();

  Stream<int> get _countStream => _countSubject.stream;

  ShareBLoC();

  void dispose() {
    _countSubject.close();
  }

  increment() {
    _countSubject.sink.add(++_count);
  }
}

class ShareProvider extends InheritedWidget {
  final ShareBLoC shareBloc;

  ShareProvider({
    Key? key,
    ShareBLoC? shareBloc,
    required Widget child,
  })  : shareBloc = shareBloc ?? ShareBLoC(),
        super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  static ShareBLoC of(BuildContext context) =>
      (context.dependOnInheritedWidgetOfExactType(aspect: ShareProvider)
              as ShareProvider)
          .shareBloc;
}
