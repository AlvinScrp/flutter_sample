import 'package:flutter/widgets.dart';

// 压缩图片大小和质量
String appendImageScaleSuffix(
    String urlString, double width, int quality, BuildContext context) {
  if (urlString.contains("x-oss-process")) {
    return urlString;
  }
  String tempStr;
  if (urlString.contains("?")) {
    tempStr = urlString + "&";
  } else {
    tempStr = urlString + "?";
  }

  MediaQueryData queryData;
  queryData = MediaQuery.of(context);
  int scaleWidth = (queryData.devicePixelRatio * width).toInt();
  int scaleQuality = quality > 100 ? 100 : quality;
  String suffixStr;
  if (urlString.contains(".gif") || urlString.contains(".GIF")) {
    suffixStr =
        "x-oss-process=image/resize,w_$scaleWidth/quality,Q_$scaleQuality";
  } else {
    suffixStr =
        "x-oss-process=image/format,webp/resize,w_$scaleWidth/quality,Q_$scaleQuality";
  }
  tempStr = tempStr + suffixStr;
  return tempStr;
}
