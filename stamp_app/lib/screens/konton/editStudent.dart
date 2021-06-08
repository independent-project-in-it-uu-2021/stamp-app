import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:stamp_app/screens/konton/raderaKonto.dart';
import 'package:stamp_app/screens/konton/makeAdmin.dart';
import 'package:stamp_app/screens/editProfile/redigera-konto.dart';
//import 'package:stamp_app/screens/main.dart';

class EditStudent extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return EditStudentState();
  }
}

class EditStudentState extends State<EditStudent> {
  // key to hold the state of the form i.e referens to the form
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  _make() {
    //Todo: Här nu för att undvika error
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Image.asset('assets/images/uuLogaNew.png', fit: BoxFit.cover),
        centerTitle: true,
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
                Padding(
                  padding: EdgeInsets.only(top: 15),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.001,
                    width: MediaQuery.of(context).size.width * 0.83,
                    color: Colors.black12,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 15),
                ),
                Text(
                  'Kalle Hansson',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 25,
                    color: Colors.black,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Image.asset(
                  'assets/images/profilbild.png',
                  fit: BoxFit.cover,
                  scale: 1.5,
                ),
                Padding(
                  padding: EdgeInsets.only(top: 20),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.001,
                    width: MediaQuery.of(context).size.width * 0.83,
                    color: Colors.black12,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 12),
                ),
                Text(
                  'Student',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.black,
                  ),
                ),
                Container(
                  height: 45,
                  width: 230,
                  child: FlatButton(
                    onPressed: () => {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => _make()),
                      ),
                    },
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15.0))),
                    color: Colors.red.shade900,
                    child: Text(
                      "Gör till administratör",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 20),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.001,
                    width: MediaQuery.of(context).size.width * 0.83,
                    color: Colors.black12,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 12),
                ),
                Text(
                  '+461234567',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.black,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 12),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.001,
                    width: MediaQuery.of(context).size.width * 0.83,
                    color: Colors.black12,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 12),
                ),
                Text(
                  'jane@xample.com',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.black,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 12),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.001,
                    width: MediaQuery.of(context).size.width * 0.83,
                    color: Colors.black12,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 12),
                ),
                Text(
                  'IT Ingenjör',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.black,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 12),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.001,
                    width: MediaQuery.of(context).size.width * 0.83,
                    color: Colors.black12,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 30),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 30),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.001,
                    width: MediaQuery.of(context).size.width * 0.83,
                    color: Colors.black12,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 30),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 50),
                  child: TextButton(
                      child: Text(
                        'Radera Konto',
                        style: TextStyle(
                          fontSize: 20,
                          decoration: TextDecoration.underline,
                          color: Colors.black,
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DeleteAccount()),
                        );
                      }),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 50),
                  child: TextButton(
                      child: Text(
                        'Redigera Konto',
                        style: TextStyle(
                          fontSize: 20,
                          decoration: TextDecoration.underline,
                          color: Colors.black,
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ProfileEdit()),
                        );
                      }),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 60),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
