import 'dart:async';

import 'package:restaurant_app/db/Model/profileModel.dart';
import 'package:restaurant_app/db/Networking/ProfileNetworking/ProfileResponse.dart';
import 'package:restaurant_app/db/Repository/ProfileRepository.dart';
import 'package:restaurant_app/jwtDecoder/jwtDecoder.dart';

class ProfileBloc {
  ProfileRepository _ProfileRepository;
  StreamController _controller;

  StreamSink<ProfileApiResponse<Profile>> get ProfileListSink =>
      _controller.sink;

  Stream<ProfileApiResponse<Profile>> get ProfileListStream =>
      _controller.stream;

  ProfileBloc() {
    _controller = StreamController<ProfileApiResponse<Profile>>();
    _ProfileRepository = ProfileRepository();
    fetchProfile();
  }

  fetchProfile() async {
    jwtDecoder jwt = jwtDecoder();
    var mobileNumber = await jwt.decode();
    ProfileListSink.add(
        ProfileApiResponse.loading('Getting Profile available'));
    try {
      Profile profile = await _ProfileRepository.getProfile(mobileNumber);
      ProfileListSink.add(ProfileApiResponse.completed(profile));
    } catch (e) {
      print(e);
      ProfileListSink.add(ProfileApiResponse.error('Error occurred'));
    }
  }

  dispose() {
    _controller?.close();
  }
}
