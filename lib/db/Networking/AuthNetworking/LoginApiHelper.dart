class LoginApiResponse<T> {
  Status status;
  T data;
  String message;

  LoginApiResponse.authenticating(this.message)
      : status = Status.AUTHENTICATING;

  LoginApiResponse.completed(this.message) : status = Status.COMPLETED;

  LoginApiResponse.error(this.message) : status = Status.ERROR;
}

enum Status { AUTHENTICATING, COMPLETED, ERROR }
