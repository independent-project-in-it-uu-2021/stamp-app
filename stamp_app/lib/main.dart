import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:stamp_app/screens/wrapper.dart';
import 'package:stamp_app/services/auth.dart';
import 'package:stamp_app/services/database.dart';
import 'package:stamp_app/models/jobsModel.dart';
import 'package:stamp_app/services/locator.dart';

void main() async {
  // Needed inorder to use firebase authentication. init firebase connection here
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  //GetIt() library function
  locatorSetUpServices();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // SteamProvider listing to Steam and exposes its content to child
    // in our case it is the current user

    return MultiProvider(
      providers: [
        StreamProvider<User>.value(
          value: AuthService().curUser,
          initialData: null,
        ),
        StreamProvider<List<Jobs>>.value(
          value: DatabaseService().allJobs,
          initialData: [],
        ),
      ],
      child: MaterialApp(
        showSemanticsDebugger: false,
        title: 'Registrera konto',
        home: Wrapper(),
      ),
    );
  }
}
