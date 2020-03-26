import 'package:flutter/widgets.dart';
import 'text_style_builders.dart';

abstract class TextBit {
  TextBlock get block;

  String get data => null;
  TextBit get first => this;
  bool get hasTrailingSpace => false;
  bool get isEmpty => false;
  bool get isNotEmpty => !isEmpty;
  TextBit get last => this;
  VoidCallback get onTap => null;
  TextStyleBuilders get tsb => null;
}

class DataBit extends TextBit {
  final TextBlock block;
  final String data;
  final VoidCallback onTap;
  final TextStyleBuilders tsb;

  DataBit(this.block, this.data, this.tsb, {this.onTap})
      : assert(block != null),
        assert(data != null),
        assert(tsb != null);

  DataBit rebuild({
    String data,
    VoidCallback onTap,
    TextStyleBuilders tsb,
  }) =>
      DataBit(
        block,
        data ?? this.data,
        tsb ?? this.tsb,
        onTap: onTap ?? this.onTap,
      );
}

class SpaceBit extends TextBit {
  final TextBlock block;
  String _data;

  SpaceBit(this.block, {String data})
      : assert(block != null),
        _data = data;

  bool get hasTrailingSpace => data == null;

  String get data => _data;
}

class WidgetBit extends TextBit {
  final TextBlock block;
  final WidgetSpan widgetSpan;

  WidgetBit(this.block, this.widgetSpan)
      : assert(block != null),
        assert(widgetSpan != null);

  WidgetBit rebuild({
    PlaceholderAlignment alignment,
    TextBaseline baseline,
    Widget child,
  }) =>
      WidgetBit(
        block,
        WidgetSpan(
          alignment: alignment ?? this.widgetSpan.alignment,
          baseline: baseline ?? this.widgetSpan.baseline,
          child: child ?? this.widgetSpan.child,
        ),
      );
}

class TextBlock extends TextBit {
  final TextBlock parent;
  final TextStyleBuilders tsb;
  final _children = <TextBit>[];

  TextBlock(this.tsb, {this.parent}) : assert(tsb != null);

  @override
  TextBlock get block => parent;

  @override
  TextBit get first {
    for (final child in _children) {
      final first = child.first;
      if (first != null) return first;
    }
    return null;
  }

  @override
  bool get hasTrailingSpace => last?.hasTrailingSpace ?? true;

  @override
  bool get isEmpty {
    for (final child in _children) {
      if (child.isNotEmpty) {
        return false;
      }
    }

    return true;
  }

  bool _lastReturnsNull = false;

  @override
  TextBit get last {
    if (_lastReturnsNull) return null;
    final l = _children.length;
    for (var i = l - 1; i >= 0; i--) {
      final last = _children[i].last;
      if (last != null) return last;
    }

    _lastReturnsNull = true;
    final parentLast = parent?.last;
    _lastReturnsNull = false;
    return parentLast;
  }

  TextBit get next {
    if (parent == null) return null;
    final siblings = parent._children;
    final indexOf = siblings.indexOf(this);
    assert(indexOf != -1);

    for (var i = indexOf + 1; i < siblings.length; i++) {
      final next = siblings[i].first;
      if (next != null) return next;
    }

    return parent.next;
  }

  void addBit(TextBit bit, {int index}) =>
      _children.insert(index ?? _children.length, bit);

  bool addSpace([String data]) {
    final prev = last;
    if (prev == null) {
      if (data == null) return false;
    } else if (prev is SpaceBit) {
      if (data == null) return false;
      prev._data = "${prev._data ?? ''}$data";
      return true;
    }

    addBit(SpaceBit(this, data: data));
    return true;
  }

  void addText(String data) => addBit(DataBit(this, data, tsb));

  void addWidget(WidgetSpan ws) => addBit(WidgetBit(this, ws));

  bool forEachBit(f(TextBit bit, int index), {bool reversed = false}) {
    final l = _children.length;
    final i0 = reversed ? l - 1 : 0;
    final i1 = reversed ? -1 : l;
    final ii = reversed ? -1 : 1;

    for (var i = i0; i != i1; i += ii) {
      final child = _children[i];
      final shouldContinue = child is TextBlock
          ? child.forEachBit(f, reversed: reversed)
          : f(child, i);
      if (shouldContinue == false) return false;
    }

    return true;
  }

  void rebuildBits(TextBit f(TextBit bit)) {
    var i = 0;
    var l = _children.length;
    while (i < l) {
      final child = _children[i];
      if (child is TextBlock) {
        child.rebuildBits(f);
      } else {
        _children[i] = f(child);
      }
      i++;
    }
  }

  TextBit removeLast() {
    while (true) {
      if (_children.isEmpty) return null;

      final lastChild = _children.last;
      if (lastChild is TextBlock) {
        final removed = lastChild.removeLast();
        if (removed != null) {
          return removed;
        } else {
          _children.removeLast();
        }
      } else {
        return _children.removeLast();
      }
    }
  }

  TextBlock sub(TextStyleBuilders tsb) {
    final sub = TextBlock(tsb, parent: this);
    _children.add(sub);
    return sub;
  }

  void trimRight() {
    while (isNotEmpty && hasTrailingSpace) removeLast();
  }
}
