import 'dart:async';

//一个字母和空格流，空格分割的字母序列都是一个单词
Stream<String> buildLetterStream() async* {
  String s = "One World One Dream";
  for (int i = 0; i < s.length; i++) {
    String letter = s.substring(i, i + 1);
    yield letter;
  }
}

main() async {
  Stream<String> letterStream = buildLetterStream();
  var wordSplitter = WordSplitter();
  //字母组成单词。字母序列-->单词序列
  Stream<String> wordStream =
      letterStream.transform(wordSplitter.transformer());
  await wordStream.forEach((word) => print(word));
}

class WordSplitter {
  StreamTransformer<String, String>? _transformer;
  StringBuffer _wordBuilder = new StringBuffer();

  StreamTransformer<String, String> transformer() {
    _transformer = StreamTransformer<String, String>.fromHandlers(
        handleData: _handleData, handleDone: _sinkWord);
    return _transformer!;
  }

  //One World One Dream
  void _handleData(String letter, EventSink<String> sink) {
    //读到空格，则把累计的字母构成单词输出。
    if (letter == " ") {
      _sinkWord(sink);
    } else {
      //否则存储字母
      _wordBuilder.write(letter);
    }
  }

  //读完时，把剩余字母构成单词输出
  void _sinkWord(EventSink<String> sink) {
    if (_wordBuilder.isNotEmpty) {
      sink.add(_wordBuilder.toString());
      _wordBuilder.clear();
    }
  }
}
