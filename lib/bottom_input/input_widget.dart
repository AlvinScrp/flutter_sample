import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InputWidget extends StatefulWidget {
  InputWidget({Key? key}) : super(key: key);

  @override
  _InputWidgetState createState() => _InputWidgetState();
}

class _InputWidgetState extends State<InputWidget> {
  @override
  Widget build(BuildContext context) {
    TextEditingController editingController = TextEditingController();

    return Scaffold(
      backgroundColor: Colors.transparent,
//      resizeToAvoidBottomInset: false,
      body: Container(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Expanded(
              child: GestureDetector(
                  onTapDown: (_) => Navigator.of(context).pop(),
                  child: Container(
                    color: Colors.transparent,
                  )),
            ),
            SafeArea(
              child: Container(
                color: Colors.white,
                child: Row(
                  children: <Widget>[
                    Container(
                      width: 20,
                    ),
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.only(top: 10, bottom: 10),
                        decoration:const BoxDecoration(
                            color: Color(0xfff6f8fb),
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        alignment: Alignment.center,
                        child: TextField(
                          autofocus: true,
                          inputFormatters: <TextInputFormatter>[
                            LengthLimitingTextInputFormatter(200)
                          ],
                          controller: editingController,
                          decoration:const InputDecoration(
                              isDense: true,
                              contentPadding: EdgeInsets.only(
                                  left: 10, right: 10, top: 5, bottom: 5),
                              border: InputBorder.none,
                              hintStyle: TextStyle(color: Color(0xffcccccc)),
                              hintText: "说点什么吧"),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: (() {
                        var text = editingController.text.trim();
                        if (text.isNotEmpty) {
                          Navigator.pop(context, text);
                        }
                      }),
                      child: Container(
                        padding: const EdgeInsets.only(
                            left: 10, right: 10, top: 10, bottom: 10),
                        alignment: Alignment.center,
                        child:const Text(
                          "发送",
                          style: TextStyle(color: Color(0xff00BBBB)),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
