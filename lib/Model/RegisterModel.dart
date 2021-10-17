class Register{
  String mobileNumber;
  String password;
  String email;
  Register({
    this.mobileNumber,
    this.password,
    this.email,
  });
}
class RegisterResponse{
  RegisterResponse.fromJson(Map<String,dynamic> json){
    print(json);
  }
}