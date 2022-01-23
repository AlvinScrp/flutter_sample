import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

typedef ShouldRebuild<A, T> = bool Function(A notifier, T value);

class ItemRefresher<A, T> extends SingleChildStatefulWidget {
  final ShouldRebuild<A, T> _shouldRebuild;
  final T value;

  ItemRefresher({
    Key? key,
    required this.value,
    required ShouldRebuild<A, T> shouldRebuild,
    required this.builder,
    Widget? child,
  })  : assert(builder != null),
        _shouldRebuild = shouldRebuild,
        super(key: key, child: child);

  final ValueWidgetBuilder<T> builder;

  @override
  _ItemRefresherState<A, T> createState() => _ItemRefresherState<A, T>();
}

class _ItemRefresherState<A, T> extends SingleChildState<ItemRefresher<A, T>> {
  Widget? cache;
  Widget? oldWidget;

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    A notifier = Provider.of(context);
    var shouldInvalidateCache = oldWidget != widget ||
        (widget._shouldRebuild != null &&
            notifier != null &&
            widget._shouldRebuild.call(notifier, widget.value));
    if (shouldInvalidateCache) {
      oldWidget = widget;
      cache = widget.builder(
        context,
        widget.value,
        child,
      );
    }
    return cache!;
  }
}
