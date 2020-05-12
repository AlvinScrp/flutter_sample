import 'dart:async';

Stream<int> countStream(int to) async* {
  for (int i = 1; i < to; i++) yield i;
}

Future<int> sumStream(Stream<int> stream) async {
  var sum = 0;
  await for (var value in stream) {
    print("$value");
    sum += value;
  }
  return sum;
}

main() async {
  var sum = await sumStream(countStream(5));
  print("sum:$sum");
}
