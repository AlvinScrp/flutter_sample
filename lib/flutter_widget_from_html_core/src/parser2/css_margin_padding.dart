part of '../core_helpers.dart';

const kCssMargin = 'margin';
const kCssMarginBottom = 'margin-bottom';
const kCssMarginLeft = 'margin-left';
const kCssMarginRight = 'margin-right';
const kCssMarginTop = 'margin-top';

const kCssPadding = 'padding';
const kCssPaddingBottom = 'padding-bottom';
const kCssPaddingLeft = 'padding-left';
const kCssPaddingRight = 'padding-right';
const kCssPaddingTop = 'padding-top';

final _valuesFourRegExp =
    RegExp(r'^([^\s]+)\s+([^\s]+)\s+([^\s]+)\s+([^\s]+)$');
final _valuesTwoRegExp = RegExp(r'^([^\s]+)\s+([^\s]+)$');

class CssMarginPaddingParser {
  final NodeMetadata meta;

  CssMarginPaddingParser(this.meta);

  CssEdgeInsets parseCssMargin() {
    CssEdgeInsets output;

    meta.styles((key, value) {
      switch (key) {
        case kCssMargin:
          output = _parseAll(value);
          break;

        case kCssMarginBottom:
        case kCssMarginLeft:
        case kCssMarginRight:
        case kCssMarginTop:
          output = _parseOne(output, key, value);
          break;
      }
    });

    return output;
  }

  CssEdgeInsets parseCssPadding() {
    CssEdgeInsets output;

    meta.styles((key, value) {
      switch (key) {
        case kCssPadding:
          output = _parseAll(value);
          break;

        case kCssPaddingBottom:
        case kCssPaddingLeft:
        case kCssPaddingRight:
        case kCssPaddingTop:
          output = _parseOne(output, key, value);
          break;
      }
    });

    return output;
  }

  EdgeInsets parseMargin(BuilderContext bc, TextStyleBuilders tsb) {
    return parseCssMargin()?.toEdgeInsets(bc, tsb);
  }

  EdgeInsets parsePadding(BuilderContext bc, TextStyleBuilders tsb) {
    return parseCssPadding()?.toEdgeInsets(bc, tsb);
  }

  CssEdgeInsets _parseAll(String value) {
    final valuesFour = _valuesFourRegExp.firstMatch(value);
    if (valuesFour != null) {
      return CssEdgeInsets()
        ..top = _parseValue(valuesFour[1])
        ..right = _parseValue(valuesFour[2])
        ..bottom = _parseValue(valuesFour[3])
        ..left = _parseValue(valuesFour[4]);
    }

    final valuesTwo = _valuesTwoRegExp.firstMatch(value);
    if (valuesTwo != null) {
      final topBottom = _parseValue(valuesTwo[1]);
      final leftRight = _parseValue(valuesTwo[2]);
      return CssEdgeInsets()
        ..bottom = topBottom
        ..left = leftRight
        ..right = leftRight
        ..top = topBottom;
    }

    final all = _parseValue(value);
    return CssEdgeInsets()
      ..bottom = all
      ..left = all
      ..right = all
      ..top = all;
  }

  CssEdgeInsets _parseOne(CssEdgeInsets existing, String key, String value) {
    final parsed = _parseValue(value);
    if (parsed == null) return existing;

    existing ??= CssEdgeInsets();

    switch (key) {
      case kCssMarginBottom:
        return existing.copyWith(bottom: parsed);
      case kCssMarginLeft:
        return existing.copyWith(left: parsed);
      case kCssMarginRight:
        return existing.copyWith(right: parsed);
      default:
        return existing.copyWith(top: parsed);
    }
  }

  CssLength _parseValue(String str) => parseCssLength(str);
}

class CssEdgeInsets {
  CssLength bottom;
  CssLength left;
  CssLength right;
  CssLength top;

  bool get isNotEmpty =>
      bottom?.isNotEmpty == true ||
      left?.isNotEmpty == true ||
      right?.isNotEmpty == true ||
      top?.isNotEmpty == true;

  CssEdgeInsets copyWith({
    CssLength bottom,
    CssLength left,
    CssLength right,
    CssLength top,
  }) =>
      CssEdgeInsets()
        ..bottom = bottom ?? this.bottom
        ..left = left ?? this.left
        ..right = right ?? this.right
        ..top = top ?? this.top;

  EdgeInsets toEdgeInsets(BuilderContext bc, TextStyleBuilders tsb) {
    return EdgeInsets.only(
      left: left?.getValue(bc, tsb) ?? 0.0,
      right: right?.getValue(bc, tsb) ?? 0.0,
      top: top?.getValue(bc, tsb) ?? 0.0,
      bottom: bottom?.getValue(bc, tsb) ?? 0.0,
    );
  }
}
