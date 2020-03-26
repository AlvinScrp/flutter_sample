part of '../core_helpers.dart';

///https://book.flutterchina.club/chapter5/transform.html
///https://www.w3school.com.cn/cssref/pr_transform.asp
///transform: rotate(-3deg) !important;transform: rotate(-3deg);
const kCssTransform = 'transform';

//final _transformRegExp = RegExp(r'^(rotate)\((-?[0-9]+deg)\)$');
final _transformRegExp = RegExp(r'^(rotate)\(((-?[0-9]+)deg)\)$');
Iterable<RegExpMatch> matchs = _transformRegExp.allMatches("rotate(-7deg)");

///m0 rotate(-7deg)  m1 rotate  m2 -7deg m3 -7

class CssTransformParser {
  final NodeMetadata meta;

  CssTransformParser(this.meta);

  Matrix4 parse(BuilderContext bc, TextStyleBuilders tsb) {
    String value;
    meta.styles((k, v) => k == kCssTransform ? value = v : null);
    if (value == null) return null;
    return parsTransform(bc, tsb, value);
  }

  Matrix4 parsTransform(
      BuilderContext bc, TextStyleBuilders tsb, String value) {
    var transformValue = value.trim().split(" ")[0];
    Iterable<RegExpMatch> matchs = _transformRegExp.allMatches(transformValue);
    if (matchs.length == 1) {
      final m = matchs.elementAt(0);
      int deg = int.tryParse(m[3]);
      double radians = 2 * math.pi * (deg / 360.0);
      print("deg:$deg , radians:$radians");
      return Matrix4.rotationZ(radians);
    }
    return null;
  }
}
