import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:stamp_app/services/database.dart';
import 'package:stamp_app/screens/checkAccount/authorization.dart';

class CheckAccount extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final currentUser = Provider.of<User>(context);
    print(currentUser.uid);
    return StreamProvider<DocumentSnapshot>.value(
      value: DatabaseService(userId: currentUser.uid).userData,
      initialData: null,
      child: Authorization(),
    );
  }
}
