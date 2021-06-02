import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:stamp_app/screens/home/home.dart';
import 'package:stamp_app/screens/inactiveHome/inactiveHome.dart';
import 'package:stamp_app/studentScreens/StudentHome/studentHome.dart';

class Authorization extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final currentUser = Provider.of<DocumentSnapshot>(context);
    if (currentUser.data().isNotEmpty) {
      var userData = currentUser.data()['accountType'];
      if (userData == 'inactive') {
        return InactiveHome();
      } else if (userData == 'student') {
        return StudentHome();
      } else {
        return Home();
      }
    }
  }
}
