import 'dart:convert';

import 'package:flutter/material.dart';


import 'package:html/dom.dart' as dom;

import 'base/app_util.dart';
import '../flutter_html/base/log.dart';

class HtmlImageWidget extends StatelessWidget {
  final dom.Element node;

  const HtmlImageWidget({Key key, this.node}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _onTapNode(context, node),
      child: _buildChlid(context, node),
    );
  }

  _onTapNode(BuildContext context, dom.Element node) {
    var src = node.attributes["src"];
    Log.i("_onTapNode ${src}");
    if (src.startsWith("data:image") && src.contains("base64,")) {
      return;
    }
//    appMethodChannel.previewImage(src);
  }

  _buildChlid(BuildContext context, dom.Element node) {
    var src = node.attributes["src"];
//    Log.i("_buildChlid ${src}");
    if (src != null) {
      if (src.startsWith("data:image") && src.contains("base64,")) {
        precacheImage(
          MemoryImage(base64.decode(src.split("base64,")[1].trim())),
          context,
          onError: null,
        );
        return Image.memory(base64.decode(src.split("base64,")[1].trim()));
      }
      precacheImage(
        NetworkImage(appendImageScaleSuffix(
            src, MediaQuery
            .of(context)
            .size
            .width, 100, context)),
        context,
        onError: null,
      );
      return Image.network(appendImageScaleSuffix(
          src, MediaQuery
          .of(context)
          .size
          .width, 100, context));
    } else if (node.attributes['alt'] != null) {
      //Temp fix for https://github.com/flutter/flutter/issues/736
      if (node.attributes['alt'].endsWith(" ")) {
        return Container(
            padding: EdgeInsets.only(right: 2.0),
            child: Text(node.attributes['alt']));
      } else {
        return Text(node.attributes['alt']);
      }
    }
    return Container();
  }
}