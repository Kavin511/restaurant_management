class OrderException implements Exception {
  final _message;
  final _prefix;

  OrderException([this._message, this._prefix]);

  String toString() {
    return '$_prefix $_message';
  }
}

class OrderFetchDataException extends OrderException {
  OrderFetchDataException([String message])
      : super(message, 'Error during communication');
}

class OrderBadRequestException extends OrderException {
  OrderBadRequestException([String message]) : super(message, 'Bad request');
}
