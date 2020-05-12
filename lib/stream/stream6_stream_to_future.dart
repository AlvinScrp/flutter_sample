import 'dart:async';

Stream<int> countStream(int to) async* {
  for (int i = 0; i < to; i++) yield i;
}

List<int> countList(int to) {
  List<int> list = List();
  for (int i = 0; i < to; i++) list.add(i);
  return list;
}

main() {
  reduce();
  forEach();
}

void reduce() async {
  Stream<int> stream = countStream(5);
  Future<int> future = stream.reduce((previous, element) => previous + element);
  var futureSum = await future;

  List<int> list = countList(5);
  var listSum = list.reduce((value, element) => value + element);
  print("reduce futureSum:$futureSum  listSum:$listSum");
}

void forEach() async {
  Stream<int> stream = countStream(5);
  StringBuffer streamSb = new StringBuffer();
  await stream.forEach((value) => streamSb.write("$value,"));

  List<int> list = countList(5);
  StringBuffer listSb = new StringBuffer();
  list.forEach((value) => listSb.write("$value,"));
  print("stream forEach:$streamSb  list forEach:$listSb");
}
