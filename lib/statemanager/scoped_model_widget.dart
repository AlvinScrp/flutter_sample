import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

///
///ScopedModel 原理等价于Provider
///
void main() => runApp(MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("ProviderWidget"),
        ),
        body: ScopedModelWidget(),
      ),
    ));

class ScopedModelWidget extends StatefulWidget {
  @override
  _ScopedModelWidgetState createState() => new _ScopedModelWidgetState();
}

class _ScopedModelWidgetState extends State<ScopedModelWidget> {
  ShareModel _shareModel = new ShareModel(0);

  @override
  Widget build(BuildContext context) {
    print("_ProviderWidget build context:$context}");
    return Center(
      child: ScopedModel<ShareModel>(
        model: _shareModel,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ScopedModelDescendant<ShareModel>(
              builder: (context2, child, model) {
                print("__TestWidgetState build context:$context2");
                return Text(
                  model.count.toString(),
                  style: TextStyle(fontSize: 40),
                );
              },
            ),
            Builder(
              builder: (context2) {
                print("__TestButtonState build context:$context2}");
                return RaisedButton(
                    child: Text(
                        "Increment (current:${ScopedModel.of<ShareModel>(context2, rebuildOnChange: true)?.count.toString()})"),
//                    "Increment (current)"),
                    onPressed: () {
                      ScopedModel.of<ShareModel>(context2,
                              rebuildOnChange: false)
                          .increment();
                    });
              },
            ),
          ],
        ),
      ),
    );
  }
}



class ShareModel extends Model {
  int count;

  ShareModel(this.count);

  void increment() {
    count++;
    notifyListeners();
  }
}
