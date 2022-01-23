import 'dart:async';

import 'package:event_bus/event_bus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sample/eventbus/my_event_bus.dart';
import 'package:flutter_sample/provider/post/base/eventbus_x.dart';

final String eventBusDemo2Title = "EventBus(pub.dev)使用";
EventBus _eventBus = new EventBus();

class EventBusDemoWidget2 extends StatefulWidget {
  EventBusDemoWidget2({Key? key}) : super(key: key);

  @override
  _EventBusDemoWidget2State createState() => _EventBusDemoWidget2State();
}

class _EventBusDemoWidget2State extends State<EventBusDemoWidget2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(eventBusDemo2Title),
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
  final T? event;

  ButtonWidget({Key? key, this.event}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: Text("increment"),
      onPressed: _increment,
    );
  }

  void _increment() {
    if (event != null) {
      event?.count++;
      print(event?.count);
      _eventBus.fire(event);
//      _eventBus.post(event);
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
//  ISubscriber<T> _subscriber;
 late StreamSubscription<T> _subscriber;

  @override
  void initState() {
    super.initState();
//    _subscriber =
//        (event) => setState(() => _count = (event as BaseEvent).count);
//    _eventBus.register<T>(_subscriber);
    Stream<T> stream = _eventBus.on<T>();
    _subscriber = stream
        .listen((event) => setState(() => _count = (event as BaseEvent).count));
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
    //    _eventBus.unregister<T>(_subscriber);
    _subscriber.cancel();
  }
}
