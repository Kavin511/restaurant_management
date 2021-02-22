import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:rect_getter/rect_getter.dart';
import 'package:restaurant_app/UI/Dashboard/Screens/Profile/Profile.dart';
import 'package:restaurant_app/db/Networking/ProfileNetworking/ProfileResponse.dart';
import 'package:restaurant_app/db/bloc/profilebloc.dart';

class Account extends StatefulWidget {
  @override
  _AccountState createState() => _AccountState();
}

class _AccountState extends State<Account> {
  final profileState = GlobalKey<_AccountState>();
  ProfileBloc profileBloc;
  GlobalKey rectGetterKey = RectGetter.createGlobalKey();
  Rect rect;
  final Duration animationDuration = Duration(milliseconds: 300);
  final Duration delay = Duration(milliseconds: 300);
  var decodedProfile;

  void onTap() {
    Get.toNamed(
      '/profileComplete',
    );
  }

  @override
  void initState() {
    profileBloc = ProfileBloc();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        color: Colors.green,
        onRefresh: () {
          return profileBloc.fetchProfile();
        },
        child: StreamBuilder<ProfileApiResponse>(
            stream: profileBloc.ProfileListStream,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                switch (snapshot.data.status) {
                  case Status.LOADING:
                    print('loading');
                    return new Container(
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                    break;
                  case Status.COMPLETED:
                    print('completed');
                    return new ProfilePage(profileData: snapshot.data.data);
                    break;
                  case Status.ERROR:
                    print('error do');
                    return new Container(
                      child: Center(
                          child: Text('Server error ,Try after some time')),
                    );
                    break;
                }
              }
              return Container();
            }),
      ),
    );
  }
}
