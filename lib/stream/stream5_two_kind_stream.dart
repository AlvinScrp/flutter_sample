import 'dart:async';

main() {
  broadcastStreamsTest();
  singleSubscriptionStreamsTest();
}

void broadcastStreamsTest() {
  //此时返回的是 _AsyncBroadcastStreamController，广播流
  var _streamController = StreamController<int>.broadcast();
  _streamController.stream.listen((event) => print("$event"));
  _streamController.stream.listen((event) => print("$event"));
  _streamController.sink.add(100);
  _streamController.close();
}

void singleSubscriptionStreamsTest() {
  //此时返回的是 _AsyncStreamController，单订阅者流
  var _streamController = StreamController<int>();
  _streamController.stream.listen((event) => print("$event"));
  _streamController.stream.listen((event) => print("$event"));
  _streamController.sink.add(100);
  _streamController.close();
}
