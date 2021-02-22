class ProfileApiResponse<T> {
  Status status;
  T data;
  String message;

  ProfileApiResponse.loading(this.message) : status = Status.LOADING;

  ProfileApiResponse.completed(this.data) : status = Status.COMPLETED;

  ProfileApiResponse.error(this.message) : status = Status.ERROR;
}

enum Status { LOADING, COMPLETED, ERROR }
