class ProfileException implements Exception {
  final _message;
  final _prefix;

  ProfileException([this._message, this._prefix]);

  String toString() {
    return '$_prefix $_message';
  }
}

class ProfileFetchDataException extends ProfileException {
  ProfileFetchDataException([String message])
      : super(message, 'Error during communication');
}

class MenuBadRequestException extends ProfileException {
  MenuBadRequestException([String message]) : super(message, 'Bad request');
}
