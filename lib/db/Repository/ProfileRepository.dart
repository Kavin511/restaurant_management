import 'package:restaurant_app/Model/profileModel.dart';
import 'package:restaurant_app/db/Networking/ProfileNetworking/ProfileApiHelper.dart';

class ProfileRepository {
  ProfileApiHelper _helper = ProfileApiHelper();

  ProfileRepository._internal();

  static final ProfileRepository _profileRepository =
      ProfileRepository._internal();

  factory ProfileRepository() {
    return _profileRepository;
  }

  dynamic response;

  Future<Profile> getProfile(var mobileNumber) async {
    if (response == null)
      response = await _helper.get('/getProfile/$mobileNumber');
    return ProfileResponse.fromJson(response).profile;
  }
}
