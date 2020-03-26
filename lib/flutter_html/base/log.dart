const bool inProduction = const bool.fromEnvironment("dart.vm.product");

class Log {
  static bool get isDebug => _isDebug != null && _isDebug == true;

  static void setDebug(bool isDebug) {
    _isDebug = isDebug;
  }

  static bool _isDebug = true;

  static void i(Object object) {
    if (isDebug) {
      print(object);
    }
  }
}
