import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:provider/provider.dart';
import 'package:redux/redux.dart';

///
///
void main() => runApp(MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("ReduxWidget"),
        ),
        body: ReduxWidgetPage(),
      ),
    ));

class ReduxWidgetPage extends StatefulWidget {
  @override
  _ReduxWidgetPageState createState() => new _ReduxWidgetPageState();
}

class _ReduxWidgetPageState extends State<ReduxWidgetPage> {
  final _store = Store<ShareData>(shareDataReducer, initialState: ShareData(0));

  @override
  Widget build(BuildContext context) {
    print("_ReduxWidget build context:$context}");
    return Center(
      child: StoreProvider<ShareData>(
        store: _store,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            StoreConnector<ShareData, int>(
              converter: (store) => store.state.count,
              builder: (context2, count) {
                print("__TestWidgetState build context:$context2");
                return Text(
                  "$count",
                  style: TextStyle(fontSize: 40),
                );
              },
            ),
            StoreConnector<ShareData, incrementCallBack>(
              converter: (store) =>
                  (step) => store.dispatch(IncrementCountAction(step)),
              builder: (context2, calback) {
                print("__TestWidgetState build context:$context2");
                return ElevatedButton(
                    child: Text(
                        "Increment (current:${ StoreProvider.of<ShareData>(context2,listen: true).state.count})"),
//                    "Increment (current)"),
                    onPressed: () {
                      calback(2);
                    });
              },
            ),
          ],
        ),
      ),
    );
  }
}

class ShareData {
  int count = 0;

  ShareData(this.count);

  void increment(int step) {
    count = count + step;
  }

  ShareData.clone(ShareData state) {
    count = state.count;
  }
}

typedef incrementCallBack = void Function(int step);

class IncrementCountAction {
  final int step;

  IncrementCountAction(this.step);
}

// The reducer, which takes the previous count and increments it in response
// to an Increment action.
ShareData shareDataReducer(ShareData state, dynamic action) {
  if (action is IncrementCountAction) {
    print('action increment count!');
    // Reducer always returns a state,never mutating the old
    return ShareData.clone(state)..increment(action.step);
  }
  return state;
}
