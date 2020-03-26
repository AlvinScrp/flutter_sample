part of '../core_helpers.dart';

const kCssBorder = 'border';
//const kCssBorderWidth = 'border-width';
//const kCssBorderStyle = 'border-style';
//const kCssBorderColor = 'border-color';

//const kCssBorderBottom = 'border-bottom';
//const kCssBorderTop = 'border-top';
//const kCssBorderLeft = 'border-left';
//const kCssBorderRight = 'border-right';
//
//const kCssBorderBottomWidth = 'border-bottom-width';
//const kCssBorderBottomStyle = 'border-bottom-style';
//const kCssBorderBottomColor = 'border-bottom-color';
//
//const kCssBorderTopWidth = 'border-top-width';
//const kCssBorderTopStyle = 'border-top-style';
//const kCssBorderTopColor = 'border-top-color';
//
//const kCssBorderLeftWidth = 'border-left-width';
//const kCssBorderLeftStyle = 'border-left-style';
//const kCssBorderLeftColor = 'border-left-color';
//
//const kCssBorderRightWidth = 'border-right-width';
//const kCssBorderRightStyle = 'border-right-style';
//const kCssBorderRightColor = 'border-right-color';

final _borderValuesThreeRegExp = RegExp(r'^(.+)\s+(.+)\s+(.+)$');
final _borderValuesTwoRegExp = RegExp(r'^(.+)\s+(.+)$');

class CssBorderParser {
  final NodeMetadata meta;

  CssBorderParser(this.meta);

  ///flutter 不支持虚线 https://github.com/flutter/flutter/issues/4858
  Border parse(BuilderContext bc, TextStyleBuilders tsb) {
    String value;
    meta.styles((k, v) => k == kCssBorder ? value = v : null);
    if (value == null) return null;
    CssBorderSide cssBorderSide = parseCssBorderSide(value);
    if (cssBorderSide == null) return null;
    BorderSide borderSide = BorderSide(
        color: cssBorderSide.color ?? Color(0x00000000),
        width: cssBorderSide.width?.getValue(bc, tsb),
        style: BorderStyle.solid);
    return Border.fromBorderSide(borderSide);
  }
}

CssBorderSide parseCssBorderSide(String value) {
  final valuesThree = _borderValuesThreeRegExp.firstMatch(value);
  if (valuesThree != null) {
    final width = parseCssLength(valuesThree[1]);
    if (width == null || width.number <= 0) return null;
    return CssBorderSide()
      ..color = parseColor(valuesThree[3])
      ..style = parseCssBorderStyle(valuesThree[2])
      ..width = width;
  }

  final valuesTwo = _borderValuesTwoRegExp.firstMatch(value);
  if (valuesTwo != null) {
    final width = parseCssLength(valuesTwo[1]);
    if (width == null || width.number <= 0) return null;
    return CssBorderSide()
      ..style = parseCssBorderStyle(valuesTwo[2])
      ..width = width;
  }

  final width = parseCssLength(value);
  if (width == null || width.number <= 0) return null;
  return CssBorderSide()
    ..style = CssBorderStyle.solid
    ..width = width;
}

CssBorderStyle parseCssBorderStyle(String value) {
  switch (value) {
    case 'dotted':
      return CssBorderStyle.dotted;
    case 'dashed':
      return CssBorderStyle.dashed;
    case 'double':
      return CssBorderStyle.double;
  }

  return CssBorderStyle.solid;
}

class CssBorderSide {
  Color color;
  CssBorderStyle style;
  CssLength width;
}

enum CssBorderStyle { dashed, dotted, double, solid }

class CssBorders {
  CssBorderSide bottom;
  CssBorderSide left;
  CssBorderSide right;
  CssBorderSide top;
}
