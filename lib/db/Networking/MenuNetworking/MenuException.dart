class MenuException implements Exception {
  final _message;
  final _prefix;
  MenuException([
    this._message,
    this._prefix
  ]);

  String toString() {
    return '$_prefix $_message';
  }
}

class MenuFetchDataException extends MenuException {
  MenuFetchDataException([String message])
      :super(message, 'Error during communication');
}

class MenuBadRequestException extends MenuException {
  MenuBadRequestException([String message]) :super(message, 'Bad request');
}
// class MenuFetchDataException extends MenuException{
//   MenuFetchDataException([String message]):super(message,'Error during communication');
// }
// class MenuFetchDataException extends MenuException{
//   MenuFetchDataException([String message]):super(message,'Error during communication');
// }