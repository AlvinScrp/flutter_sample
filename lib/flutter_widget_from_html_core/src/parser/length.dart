part of '../core_helpers.dart';

final _lengthRegExp = RegExp(r'^([\d\.]+)(em|px)$');

class CssLength {
  final double number;
  final CssLengthUnit unit;

  CssLength(
    this.number, {
    this.unit = CssLengthUnit.px,
  })  : assert(!number.isNegative),
        assert(unit != null);

  bool get isNotEmpty => number > 0;

  double getValue(BuilderContext bc, TextStyleBuilders tsb) {
    double value;

    switch (this.unit) {
      case CssLengthUnit.em:
        value = tsb.build(bc).fontSize * number / 1;
        break;
      case CssLengthUnit.px:
        value = number;
        break;
    }

    if (value != null) {
      value = value * MediaQuery.of(bc.context).textScaleFactor;
    }

    return value;
  }
}

enum CssLengthUnit {
  em,
  px,
}

CssLength parseCssLength(String value) {
  if (value == null) return null;
  if (value == '0') return CssLength(0);

  final match = _lengthRegExp.firstMatch(value);
  if (match == null) return null;

  final number = double.tryParse(match[1]);
  if (number == null) return null;

  switch (match[2]) {
    case 'em':
      return CssLength(number, unit: CssLengthUnit.em);
    case 'px':
      return CssLength(number, unit: CssLengthUnit.px);
  }

  return null;
}
