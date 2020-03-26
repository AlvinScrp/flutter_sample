

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import 'html2.dart';

class NicoHtmlWidget extends StatefulWidget {
  final String htmlData;

  final FrameCallback frameCallback;

  NicoHtmlWidget({this.htmlData, this.frameCallback});

  @override
  _NicoHtmlWidgetState createState() => _NicoHtmlWidgetState();
}

class _NicoHtmlWidgetState extends State<NicoHtmlWidget> {
  @override
  void initState() {
    super.initState();
//    Log.i("${DateTime.now().millisecondsSinceEpoch} timestmp:html initState  ");
    FrameCallback frameCallback = widget.frameCallback;
    if (frameCallback != null) {
      WidgetsBinding.instance.addPostFrameCallback(frameCallback);
    }
  }

  @override
  Widget build(BuildContext context) {

    return Html2(data: widget.htmlData,useRichText: false);
//    return Html(
//      data: widget.htmlData,
//      useRichText: false,
//      customRender: (node, children) {
//        if (node is dom.Element) {
//          switch (node.localName) {
//            case "video":
//              return NicoVideoWidget(node.attributes["src"]);
//            case "img":
//              return NicoHtmlImageWidget(node: node);
//          }
//        }
//        return null;
//      },
//    );


  }
}


