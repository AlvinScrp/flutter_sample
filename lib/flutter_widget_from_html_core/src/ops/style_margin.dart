part of '../core_widget_factory.dart';

Iterable<Widget> _marginBuilder(
  BuilderContext bc,
  Iterable<Widget> children,
  _MarginBuilderInput input,
) {
  final tsb = input.meta.tsb;
  final padding = EdgeInsets.only(
    left: input.margin?.left?.getValue(bc, tsb) ?? 0.0,
    right: input.margin?.right?.getValue(bc, tsb) ?? 0.0,
    top: input.margin?.top?.getValue(bc, tsb) ?? 0.0,
    bottom: input.margin.bottom?.getValue(bc, tsb) ?? 0.0,
  );

  var widget = input.wf
      .buildBoxContainer(input.wf.buildColumn(children), margin: padding);
  return listOfNonNullOrNothing(widget);
}

class _MarginBuilderInput {
  CssEdgeInsets margin;
  NodeMetadata meta;
  WidgetFactory wf;
}

class _StyleMargin {
  final WidgetFactory wf;

  _StyleMargin(this.wf);

  BuildOp get buildOp => BuildOp(
        isBlockElement: true,
        onWidgets: (meta, widgets) {
          if (widgets?.isNotEmpty != true) return null;
          final m = CssMarginPaddingParser(meta).parseCssMargin();
          if (m == null) return null;
          final input = _MarginBuilderInput()
            ..margin = m
            ..meta = meta
            ..wf = wf;
          var widget = WidgetPlaceholder(
            builder: _marginBuilder,
            children: widgets,
            input: input,
          );
          return [widget];
        },
      );
}
