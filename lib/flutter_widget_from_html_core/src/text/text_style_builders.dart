import 'package:flutter/widgets.dart';

typedef TextStyle TextStyleBuilder<T>(
  TextStyleBuilders tsb,
  TextStyle textStyle,
  T input,
);

class TextStyleBuilders {
  final _builders = <Function>[];
  final _inputs = [];
  final TextStyleBuilders parent;

  BuilderContext _bc;
  TextStyle _output;
  TextAlign _textAlign;

  BuilderContext get bc => _bc;

  TextAlign get textAlign => _textAlign ?? parent?.textAlign;

  set textAlign(TextAlign v) => _textAlign = v;

  TextStyleBuilders({this.parent});

  void enqueue<T>(TextStyleBuilder<T> builder, T input) {
    assert(_output == null, "Cannot add builder after being built");
    _builders.add(builder);
    _inputs.add(input);
  }

  TextStyle build(BuilderContext bc) {
    _resetContextIfNeeded(bc);
    if (_output != null) return _output;

    if (parent == null) {
      _output = DefaultTextStyle.of(_bc.context).style;
    } else {
      _output = parent.build(_bc);
    }

    final l = _builders.length;
    for (int i = 0; i < l; i++) {
      _output = _builders[i](this, _output, _inputs[i]);
    }

    return _output;
  }

  TextStyleBuilders sub() => TextStyleBuilders(parent: this);

  void _resetContextIfNeeded(BuilderContext bc) {
    if (bc == _bc) return;

    _bc = bc;
    _output = null;
    _textAlign = null;
  }
}

class BuilderContext {
  final BuildContext context;
  final Widget origin;

  BuilderContext(this.context, this.origin);
}
