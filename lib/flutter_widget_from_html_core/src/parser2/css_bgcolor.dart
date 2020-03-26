part of '../core_helpers.dart';

const kCssBackgroundColor = 'background-color';

class CssBgColorParser {
  final NodeMetadata meta;

  CssBgColorParser(this.meta);

  Color parse() {
    String value;
    meta.styles((k, v) => k == kCssBackgroundColor ? value = v : null);
    if (value == null) return null;
    return parseColor(value);
  }
}
