import 'package:flutter/material.dart';
import 'package:stamp_app/screens/konton/hanteraKonton.dart';
import 'package:stamp_app/services/database.dart'; // as _userDataFromSnapshot;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:stamp_app/models/user.dart';
import 'package:provider/provider.dart';

class DeleteAccount extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return DeleteAccountState();
  }
}

class DeleteAccountState extends State<DeleteAccount> {
  // key to hold the state of the form i.e referens to the form
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  //TODO: Check if an email is already used

  @override
  Widget build(BuildContext context) {
    final _currentUser = Provider.of<User>(context);
//var collection = FirebaseFirestore.instance.collection('users');
//var querySnapshots = _currentUser.delete();

    _currentUser.delete();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Image.asset('assets/images/uuLogaNew.png', fit: BoxFit.cover),
        //centerTitle: true,
        backgroundColor: Colors.red.shade900,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_rounded),
          //TODO: This does nothing now
          onPressed: () => Navigator.of(context).pop(),
          tooltip: 'Tillbaka',
        ),
      ),
      body: Container(
        width: double.infinity,
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 30),
                ),
                Text(
                  'Är du säker på att du vill radera ditt konto?',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 25,
                    color: Colors.black,
                  ),
                ),
                Container(
                  height: 45,
                  width: 230,
                  child: FlatButton(
                    onPressed: () => Navigator.of(context).pop(),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15.0))),
                    color: Colors.grey.shade900,
                    child: Text(
                      "Ångra",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 45,
                  width: 230,
                  child: FlatButton(
                    onPressed: () => {
                      _currentUser.delete(),
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ManageAccount()),
                      )
                    },
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15.0))),
                    color: Colors.red.shade900,
                    child: Text(
                      "Radera",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
