import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:stamp_app/models/user.dart';
import 'package:stamp_app/screens/home/home.dart';
import 'package:stamp_app/screens/inactiveHome/inactiveHome.dart';
import 'package:stamp_app/sharedWidget/loadingScreen.dart';
import 'package:stamp_app/studentScreens/StudentHome/studentHome.dart';

class Authorization extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final currentUser = Provider.of<UserData>(context);
    if (currentUser != null) {
      var userData = currentUser.accountType;
      if (userData.compareTo('inactive') == 0) {
        return InactiveHome();
      } else if (userData.compareTo('student') == 0) {
        return StudentHome();
      } else {
        return Home();
      }
    } else {
      return LoadingScreen();
    }
  }
}
