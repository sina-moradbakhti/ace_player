class AppRoutes {
  static final AppRoutes _singleton = AppRoutes._internal();
  factory AppRoutes() {
    return _singleton;
  }
  AppRoutes._internal();

  static const String splash = '/splash';
  static const String main = '/main';
}
