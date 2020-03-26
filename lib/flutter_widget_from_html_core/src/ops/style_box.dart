part of '../core_widget_factory.dart';

Iterable<Widget> _boxBuilder(
  BuilderContext bc,
  Iterable<Widget> children,
  _BoxBuilderInput input,
) {
  if (children?.isNotEmpty != true) return null;
  final tsb = input.meta.tsb;
  final meta = input.meta;

  EdgeInsets margin = CssMarginPaddingParser(meta).parseMargin(bc, tsb);
  EdgeInsets padding = CssMarginPaddingParser(meta).parsePadding(bc, tsb);
  final bgColor = CssBgColorParser(meta).parse();
  Border border = CssBorderParser(meta).parse(bc, tsb);
  BorderRadius borderRadius = CssBorderRadiusParser(meta).parse(bc, tsb);
  List<BoxShadow> boxShadow = CssBoxShadowParser(meta).parse(bc, tsb);

  var child = children.length == 1
      ? children.elementAt(0)
      : input.wf.buildColumn(children);
  var widget = input.wf.buildBoxContainer(child,
      margin: margin,
      padding: padding,
      color: bgColor,
      border: border,
      borderRadius: borderRadius,
      boxShadow: boxShadow);
  return listOfNonNullOrNothing(widget);
}

class _BoxBuilderInput {
  NodeMetadata meta;
  WidgetFactory wf;
}

class _StyleBox {
  final WidgetFactory wf;

  _StyleBox(this.wf);

  BuildOp get buildOp => BuildOp(
//        isBlockElement: false,
        onPieces: (meta, pieces) {
          final bgColor = CssBgColorParser(meta).parse();
          if (bgColor == null) return pieces;

          return pieces.map((p) => p.hasWidgets ? p : _buildBlock(p, bgColor));
        },
        onWidgets: (meta, widgets) {
          if (widgets?.isNotEmpty != true) return null;
          final input = _BoxBuilderInput()
            ..meta = meta
            ..wf = wf;
          var widget = WidgetPlaceholder(
            builder: _boxBuilder,
            children: widgets,
            input: input,
          );
          return [widget];
        },
      );

  BuiltPiece _buildBlock(BuiltPiece piece, Color bgColor) => piece
    ..block.rebuildBits((bit) => bit is DataBit
        ? bit.rebuild(
            tsb: bit.tsb.sub()..enqueue(_styleBgColorTextStyleBuilder, bgColor),
          )
        : bit);
}
