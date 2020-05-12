//周期性发送整数Stream，当使用yield时，向Stream提交事件(一个整数)
import 'dart:async';

Stream<int> timedCounter(Duration interval, [int maxCount]) async* {
  int i = 0;
  while (true) {
    await Future.delayed(interval);
    yield i++;
    if (i == maxCount) break;
  }
}

main() {
  Stream<int> stream = timedCounter(Duration(milliseconds: 200), 5);
  StreamSubscription<int> subscription =
      stream.listen(_onData, onDone: _onDone);
  _delayCancel(subscription, milliseconds: 500);
}

void _onData(int event) => print("$event");

void _onDone() => print("onDone");

void _delayCancel(StreamSubscription<int> subscription, {int milliseconds}) {
  Future.delayed(Duration(milliseconds: milliseconds))
      .then((value) => subscription.cancel());
}
