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
  map();
}

void map() async {
  Stream<int> stream = countStream(5);
  Stream<String> strStream = stream.map((event) => "index($event)");
  StringBuffer streamSb = new StringBuffer();
  await strStream.forEach((value) => streamSb.write("$value,"));

  List<int> list = countList(5);
  StringBuffer listSb = new StringBuffer();
  var strList = list.map((e) => "index($e)").toList();
  strList.forEach((element) => listSb.write("$element,"));
  print("map stream:$streamSb  list:$listSb");
}
