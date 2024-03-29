import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:stamp_app/services/auth.dart';
import 'package:stamp_app/sharedWidget/inputDecoration.dart';
import 'package:stamp_app/sharedWidget/loadingScreen.dart';
import 'package:stamp_app/sharedWidget/errorMsg.dart';

class LogIn extends StatefulWidget {
  final Function toggleFunc;
  LogIn({this.toggleFunc});

  @override
  State<StatefulWidget> createState() {
    return LogInState();
  }
}

class LogInState extends State<LogIn> {
  // State parameter
  String _email;
  String _userPassword;
  String _erroMsg = '';
  bool loading = false;

  // Authentication instance used to login
  final AuthService _auth = AuthService();

  // key to hold the state of the form i.e referens to the form
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  //TODO: Check if an email is already used
  Widget _buildEmail() {
    return Container(
      width: 350,
      child: TextFormField(
        keyboardType: TextInputType.emailAddress,
        //Decorate the input field here,
        decoration: textInputDecoration.copyWith(hintText: 'E-post'),
        validator: (String value) {
          if (value.isEmpty) {
            return 'E-post är obligatoriskt.';
          }
          if (!RegExp(
                  r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
              .hasMatch(value)) {
            return 'Ogiltig mejladress';
          }
          if (value.length > 255) {
            return 'Mejladress får inte vara längre än 255 tecken';
          }
          return null;
        },
        //The form is saved and we tell what to do with the value
        onChanged: (String value) {
          setState(() {
            _email = value;
          });
        },
      ),
    );
  }

  Widget _buildPassword() {
    return Container(
      width: 350,
      child: TextFormField(
        keyboardType: TextInputType.visiblePassword,
        obscureText: true,
        enableSuggestions: false,
        autocorrect: false,
        //Decorate the input field here
        decoration: textInputDecoration.copyWith(hintText: 'Lösenord'),
        //The actual value from the input
        validator: (String value) {
          if (value.isEmpty) {
            return 'Lösenord är obligatoriskt';
          }
          return null;
        },
        //The form is saved and we tell what to do with the value
        onChanged: (String value) {
          setState(() {
            _userPassword = value;
          });
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? LoadingScreen()
        : Scaffold(
            backgroundColor: Colors.red.shade900,
            appBar: AppBar(
              title:
                  Image.asset('assets/images/uuLogaNew.png', fit: BoxFit.cover),
              centerTitle: true,
              backgroundColor: Colors.red.shade900,
              elevation: 0,
            ),
            body: Container(
              width: double.infinity,
              margin: EdgeInsets.only(top: 40),
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Välkommen!',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 50,
                          color: Colors.white,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 70),
                      ),
                      Text(
                        'Vänligen logga in',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 30,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      _buildEmail(),
                      Padding(
                        padding: EdgeInsets.only(top: 30),
                      ),
                      _buildPassword(),
                      Padding(
                        padding: EdgeInsets.only(top: 40),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.5,
                        height: MediaQuery.of(context).size.height * 0.06,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50),
                              )),
                          child: Text(
                            'Logga in',
                            style: TextStyle(color: Colors.black, fontSize: 28),
                          ),
                          onPressed: () async {
                            //If the form is valid, onSaved method is called
                            if (_formKey.currentState.validate()) {
                              setState(() => loading = true);
                              _formKey.currentState.save();
                              // sign in method from auth.dart file is called here
                              try {
                                dynamic result =
                                    await _auth.signInWithEmailAndPassword(
                                        _email, _userPassword);
                              } on FirebaseAuthException catch (e) {
                                setState(() {
                                  loading = false;
                                  _erroMsg = ErrorMessage(errorMsg: e.code)
                                      .errorMessageLogin();
                                });
                              }
                            }
                          },
                        ),
                      ),
                      SizedBox(
                        height: 14,
                      ),
                      Text(
                        _erroMsg,
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 50),
                        child: TextButton(
                          child: Text(
                            'Registrera Konto',
                            style: TextStyle(
                              fontSize: 20,
                              decoration: TextDecoration.underline,
                              color: Colors.black,
                            ),
                          ),
                          onPressed: () {
                            widget.toggleFunc();
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
  }
}
