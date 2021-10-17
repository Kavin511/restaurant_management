class Login{
  String mobileNumber;
  String password;
  Login({
    this.mobileNumber,
    this.password
  });
}
class LoginResponse{
  LoginResponse.fromJson(Map<String,dynamic> json){
    print(json);
  }
}