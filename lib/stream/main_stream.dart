import 'dart:async';

main() {
  // ignore: close_sinks
  var _streamController = new StreamController();
  _streamController.stream.listen((event) => print("$event"));
  _streamController.stream.listen((event) => print("$event"));
  _streamController.sink.add(100);
  _streamController.add("xxx");
}
