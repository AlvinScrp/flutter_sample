part of '../core_widget_factory.dart';

Iterable<Widget> _transformBuilder(
  BuilderContext bc,
  Iterable<Widget> children,
  _TransformBuilderInput input,
) {
  if (children?.isNotEmpty != true) return null;
  final tsb = input.meta.tsb;
  final meta = input.meta;

  var matrix4 = CssTransformParser(meta).parse(bc, tsb);

  var child = children.length == 1
      ? children.elementAt(0)
      : input.wf.buildColumn(children);
  var widget = input.wf.buildTransform(child, matrix4);
  return listOfNonNullOrNothing(widget);
}

class _TransformBuilderInput {
  NodeMetadata meta;
  WidgetFactory wf;
}

class _StyleTransform {
  final WidgetFactory wf;

  _StyleTransform(this.wf);

  BuildOp get buildOp => BuildOp(
        isBlockElement: true,
        onWidgets: (meta, widgets) {
          if (widgets?.isNotEmpty != true) return null;
          final input = _TransformBuilderInput()
            ..meta = meta
            ..wf = wf;
          var widget = WidgetPlaceholder(
            builder: _transformBuilder,
            children: widgets,
            input: input,
          );
          return [widget];
        },
      );
}
