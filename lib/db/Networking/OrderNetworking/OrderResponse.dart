class OrderApiResponse<T> {
  Status status;
  T data;
  String message;

  OrderApiResponse.loading(this.message) : status = Status.LOADING;

  OrderApiResponse.completed(this.data) : status = Status.COMPLETED;

  OrderApiResponse.error(this.message) : status = Status.ERROR;
}

enum Status { LOADING, COMPLETED, ERROR }
