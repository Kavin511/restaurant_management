class AppContext {
  static final AppContext _appContext = AppContext._internal();

  factory AppContext() {
    return _appContext;
  }

  AppContext._internal();
}
