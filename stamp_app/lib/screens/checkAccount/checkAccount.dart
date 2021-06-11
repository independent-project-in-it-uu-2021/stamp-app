import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:stamp_app/models/user.dart';
import 'package:stamp_app/screens/home/home.dart';
import 'package:stamp_app/models/jobsModel.dart';

import 'package:stamp_app/services/database.dart';
import 'package:stamp_app/screens/checkAccount/authorization.dart';

class CheckAccount extends StatelessWidget {
  //Checks which type of account it is when user logged in.
  @override
  Widget build(BuildContext context) {
    print("hej");
    final currentUser = Provider.of<User>(context);
    print(currentUser.uid);
    return StreamProvider.value(
      value: DatabaseService(userId: currentUser.uid).userData,
      initialData: UserData().newDummyUser(),
      child: Authorization(),
    );
    /*return MultiProvider(providers: [
      //StreamProvider for user information
      StreamProvider<UserData>.value(
        value: DatabaseService(userId: currentUser.uid).userData,
        initialData: UserData().newDummyUser(),
        //child: Authorization(),
      ),
      //StreamProvider for all the jobs
      StreamProvider<List<Jobs>>.value(
        value: DatabaseService().allJobs,
        initialData: [],
        //child: Home(),
      )
    ], child: Authorization());*/
  }
}
