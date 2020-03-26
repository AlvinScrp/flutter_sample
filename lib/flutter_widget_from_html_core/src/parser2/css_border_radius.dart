part of '../core_helpers.dart';

const kCssBorderRadius = 'border-radius';

class CssBorderRadiusParser {
  final NodeMetadata meta;

  CssBorderRadiusParser(this.meta);

  CssLength parseCssRadius() {
    String value;
    meta.styles((k, v) => k == kCssBorderRadius ? value = v : null);
    if (value == null) return null;
    return parseCssLength(value);
  }

  BorderRadius parse(BuilderContext bc, TextStyleBuilders tsb) {
    CssLength cssLength = parseCssRadius();
    if (cssLength == null) return null;
    return BorderRadius.all(
        Radius.circular(cssLength?.getValue(bc, tsb) ?? 0.0));
  }
}
