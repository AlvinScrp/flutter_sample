import 'package:flutter/material.dart';
import 'package:flutter_sample/eventbus/my_event_bus.dart';
import 'package:flutter_sample/provider/post/base/eventbus_x.dart';

final String eventBusDemo1Title = "自定义EventBus";
MyEventBus1 _eventBus = new MyEventBus1();

class EventBusDemoWidget1 extends StatefulWidget {
  EventBusDemoWidget1({Key key}) : super(key: key);

  @override
  _EventBusDemoWidget1State createState() => _EventBusDemoWidget1State();
}

class _EventBusDemoWidget1State extends State<EventBusDemoWidget1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(eventBusDemo1Title),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                new ButtonWidget(event: new EventA()),
                new TextWidget<EventA>(),
                new TextWidget<EventA>()
              ],
            ),
            Divider(
              color: Colors.grey,
            ),
            Row(
              children: <Widget>[
                new ButtonWidget(event: new EventB()),
                new TextWidget<EventB>(),
                new TextWidget<EventB>()
              ],
            )
          ],
        ),
      ),
    );
  }
}

class BaseEvent {
  int count = 0;
}

class EventA extends BaseEvent {}

class EventB extends BaseEvent {}

class ButtonWidget<T extends BaseEvent> extends StatelessWidget {
  final T event;

  const ButtonWidget({Key key, this.event}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      child: Text("increment"),
      onPressed: _increment,
    );
  }

  void _increment() {
    if (event != null) {
      event.count++;
      print(event.count);
      _eventBus.post(event);
    }
  }
}

class TextWidget<T> extends StatefulWidget {
  @override
  _TextWidgetState<T> createState() {
    return _TextWidgetState<T>();
  }
}

class _TextWidgetState<T> extends State<TextWidget<T>> {
  int _count = 0;
  ISubscriber<T> _subscriber;

  @override
  void initState() {
    super.initState();

    _subscriber =
        (event) => setState(() => _count = (event as BaseEvent).count);
    _eventBus.register<T>(_subscriber);
  }

  @override
  Widget build(BuildContext context) {
    print(typeOf<T>());
    return Text(
      "   $_count  ",
      style: TextStyle(fontSize: 18),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _eventBus.unregister<T>(_subscriber);
  }
}
