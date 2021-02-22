import 'dart:typed_data';

class Profile {
  String mobileNumber;

  String email;
  String address;
  String hotelName;
  ByteBuffer dp;
  ByteBuffer cover;

  Profile({
    // this.mobileNumber
    this.mobileNumber,
    this.email,
    this.address,
    this.hotelName,
    this.dp,
    this.cover,
  });

  Profile.fromJson(Map<String, dynamic> json) {
    mobileNumber = json['mobileNumber'];
    email = json['email'];
    address = json['address'];
    hotelName = json['hotelName'];
    dp = json['dp'];
    cover = json['cover'];
  }
}

class ProfileResponse {
  Profile profile;

  ProfileResponse({this.profile});

  ProfileResponse.fromJson(Map<String, dynamic> json) {
    print(json['result']);
    print('above');
    if (json['result'] != null) {
      profile = new Profile.fromJson(json['result']);
    }
  }
}
