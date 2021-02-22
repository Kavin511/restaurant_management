import 'package:restaurant_app/db/Model/profileModel.dart';
import 'package:restaurant_app/db/Networking/ProfileNetworking/ProfileApiHelper.dart';

class ProfileRepository {
  ProfileApiHelper _helper = ProfileApiHelper();

  Future<Profile> getProfile(var mobileNumber) async {
    final response = await _helper.get('/getProfile/$mobileNumber');
    return ProfileResponse.fromJson(response).profile;
  }
}
