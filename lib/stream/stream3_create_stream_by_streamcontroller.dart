import 'dart:async';

main() {
  var controller = StreamController<int>();
  controller.stream.listen(_onData, onDone: _onDone);
  controller.add(1);
  controller.add(2);
  controller.add(3);
  controller.close();
}

void _onData(int event) => print("$event");

void _onDone() => print("onDone");
