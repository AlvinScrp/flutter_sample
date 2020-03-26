part of '../core_helpers.dart';

///* x偏移量 | y偏移量 | 阴影模糊半径 | 阴影扩散半径 | 阴影颜色 */
///box-shadow: 3px 3px 3px 3px #F4AAB9;
const kCssBoxShadow = 'box-shadow';

class CssBoxShadowParser {
  final NodeMetadata meta;

  CssBoxShadowParser(this.meta);

  List<BoxShadow> parse(BuilderContext bc, TextStyleBuilders tsb) {
    String value;
    meta.styles((k, v) => k == kCssBoxShadow ? value = v : null);
    if (value == null) return null;
    return parseBoxShadow(bc, tsb, value);
  }

  List<BoxShadow> parseBoxShadow(
      BuilderContext bc, TextStyleBuilders tsb, String value) {
    var values = value.trim().split(" ");
    if (values.length == 5) {
      double dx = parseCssLength(values[0]).getValue(bc, tsb);
      double dy = parseCssLength(values[1]).getValue(bc, tsb);
      double blurRadius = parseCssLength(values[2]).getValue(bc, tsb);
      double spreadRadius = parseCssLength(values[3]).getValue(bc, tsb);
      Color color = parseColor(values[4]);

      var boxShadow = BoxShadow(
          color: color,
          offset: Offset(dx, dy),
          blurRadius: blurRadius,
          spreadRadius: spreadRadius);
      return [boxShadow];
    }
    return null;
  }
}
