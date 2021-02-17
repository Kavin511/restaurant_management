class MenuResponse<T> {
  Status status;
  T data;
  String message;

  MenuResponse.loading(this.message) :status=Status.LOADING;

  MenuResponse.completed(this.message) :status=Status.COMPLETED;

  MenuResponse.error(this.message) :status=Status.ERROR;
}
enum Status {
  LOADING,
  COMPLETED,
  ERROR
}