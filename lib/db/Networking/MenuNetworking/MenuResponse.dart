class MenuApiResponse<T> {
  Status status;
  T data;
  String message;

  MenuApiResponse.loading(this.message) : status = Status.LOADING;

  MenuApiResponse.completed(this.data) : status = Status.COMPLETED;

  MenuApiResponse.error(this.message) : status = Status.ERROR;
}

enum Status {
  LOADING,
  COMPLETED,
  ERROR
}