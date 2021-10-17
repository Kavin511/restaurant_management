import 'package:restaurant_app/Model/LoginModel.dart';
import 'package:restaurant_app/Services/Auth/Authservice.dart';

class LoginRepository {
  AuthService _helper = AuthService();

  loginUser(Login login) async {
    final response = await _helper.login(login.mobileNumber,login.password);
    print(response);
    return response;
  }
}
