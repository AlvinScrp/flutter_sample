import 'package:flutter/material.dart';
import 'bottom_input/input_dialog.dart';

void main() => runApp(MaterialApp(home: InputHomeWidget()));

class InputHomeWidget extends StatefulWidget {
  @override
  _InputHomeWidgetState createState() => _InputHomeWidgetState();
}

class _InputHomeWidgetState extends State<InputHomeWidget> {
  String _inputString = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /**弹出键盘会导致bottomInset值变化，可以通过MediaQuery获取到各种值。
      resizeToAvoidBottomInset：true(默认值)，
      表示根据变化重新Build，页面会被顶到键盘上，当然也可以通过scollView处理 **/
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text("底部输入框"),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          FlatButton(
            color: Colors.yellow,
            onPressed: _input,
            child: Text("弹出底部输入框"),
          ),
          Expanded(child: Text("结果:$_inputString")),
          Text("底部文案"),
          Container(
            height: 100,
            width: 20,
          )
        ],
      ),
    );
  }

  void _input() {
    InputDialog.show(context).then((value) {
      setState(() {
        _inputString = value;
      });
    });
  }
}
