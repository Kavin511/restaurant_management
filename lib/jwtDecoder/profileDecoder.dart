import 'package:jwt_decoder/jwt_decoder.dart';

class ProfileDecoder {
  decode(String token) async {
    if (token != "") {
      Map<String, dynamic> decodedToken = JwtDecoder.decode(token);
      print(decodedToken);
    }
  }
}
