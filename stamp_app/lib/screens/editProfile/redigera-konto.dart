import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:stamp_app/services/auth.dart';
import 'package:stamp_app/sharedWidget/editProfileDecoration.dart';
import 'package:stamp_app/services/locator.dart';
import 'package:stamp_app/sharedWidget/errorMsg.dart';
import 'package:stamp_app/services/database.dart';
import 'package:stamp_app/sharedWidget/dialogWidget.dart';

class ProfileEdit extends StatefulWidget {
  final String userID;
  final String userName;
  final String userNumber;
  final String userEmail;
  final String userBio;
  final String userProfileImgUrl;
  ProfileEdit(
      {this.userID,
      this.userName,
      this.userNumber,
      this.userEmail,
      this.userBio,
      this.userProfileImgUrl});
  @override
  State<StatefulWidget> createState() {
    return ProfileEditState();
  }
}

class ProfileEditState extends State<ProfileEdit> {
  // State parameter
  String _userID = '';
  String _userName = '';
  String _userNumber = '';
  String _userEmail = '';
  String _userBio = '';
  String _userPassword = '';
  bool _changePassword = false;
  bool _changeEmail = false;
  String _msgShown = '';
  String _errorMsgDeleteAccount = '';
  final AuthService _firebaseAuth = AuthService();

  @override
  void initState() {
    super.initState();
    _userID = widget.userID;
    _userName = widget.userName;
    _userEmail = widget.userEmail;
    _userNumber = widget.userNumber;
    _userBio = widget.userBio;
  }

  // key to hold the state of the form i.e referens to the form
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // Function for the name
  Widget _buildName() {
    return Container(
      width: 350,
      child: TextFormField(
        initialValue: widget.userName,
        keyboardType: TextInputType.name,
        // Decorate the input field here,
        decoration:
            editProfileInputDecoration.copyWith(hintText: 'Förnamn Efternamn'),
        // The acutal value from the input
        validator: (String value) {
          if (value.isEmpty) {
            return 'Namn är obligatorisk';
          }
          if (value.length > 120) {
            return 'Namn får inte vara längre än 120 tecken';
          }
          return null;
        },
        // The  form is saved and we tell what to do with the value
        onSaved: (String value) {
          _userName = value;
        },
      ),
    );
  }

  Widget _buildEmail() {
    return Container(
      width: 350,
      child: TextFormField(
        initialValue: widget.userEmail,
        keyboardType: TextInputType.emailAddress,
        decoration: editProfileInputDecoration.copyWith(hintText: 'E-post'),
        // The acutal value from the input
        validator: (String value) {
          if (_changeEmail == true) {
            if (value.isEmpty) {
              return 'E-post är obligatorisk';
            }
            if (value.length > 120) {
              return 'Mejladress får inte vara längre än 120 tecken';
            }
            // Check valid character for email
            if (!RegExp(
                    r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
                .hasMatch(value)) {
              return 'Ogiltig mejladress';
            }
          }
          return null;
        },
        // The  form is saved and we tell what to do with the value
        onChanged: (String value) {
          setState(() => _changeEmail = true);
          _userEmail = value;
        },
      ),
    );
  }

  Widget _buildNumber() {
    if (widget.userNumber == 'Telefonnummer saknas') {
      _userNumber = '';
    }
    return Container(
      width: 350,
      child: TextFormField(
        initialValue: _userNumber,
        keyboardType: TextInputType.number,
        // Decorate the input field here,
        decoration: editProfileInputDecoration.copyWith(
            hintText: 'Telefonnummer (Frivilligt)'),

        // The  form is saved and we tell what to do with the value
        onSaved: (String value) {
          _userNumber = value;
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
        // Decorate the input field here,
        decoration: editProfileInputDecoration.copyWith(hintText: 'Lösenord'),
        // The acutal value from the input

        validator: (String value) {
          if (_changePassword == true) {
            if (value.isEmpty) {
              return 'Lösenord är obligatorisk';
            } else if (value.length < 6) {
              return 'Lösenord behöver vara minst 6 tecken';
            }
          }
          return null;
        },
        onChanged: (String value) {
          setState(() => _changePassword = true);
          //_changePassword = true;
          _userPassword = value;
        },
      ),
    );
  }

  Widget _checkUserPassword() {
    return Container(
      width: 350,
      child: TextFormField(
        obscureText: true,
        enableSuggestions: false,
        autocorrect: false,
        keyboardType: TextInputType.visiblePassword,
        // Decorate the input field here,
        decoration:
            editProfileInputDecoration.copyWith(hintText: 'Upprepa lösenord'),
        // The acutal value from the input
        validator: (String value) {
          if (_changePassword == true) {
            if (value.isEmpty) {
              return 'Upprepa lösenord är obligatorisk';
            } else if (value != _userPassword) {
              return 'Vänligen ange samma lösenord';
            } else if (value.length < 6) {
              return 'Lösenord behöver vara minst 6 tecken';
            }
          }
          return null;
        },
      ),
    );
  }

  //Write bio if "Övrigt" is choosen in the dropdown meny
  Widget _buildBio() {
    return Container(
      width: 350,
      child: TextFormField(
        initialValue: widget.userBio,
        keyboardType: TextInputType.name,
        maxLength: 300,
        // Decorate the input field here,
        decoration: editProfileInputDecoration.copyWith(hintText: 'Kort bio'),
        // The acutal value from the input
        validator: (String value) {
          if (value.isEmpty) {
            return 'Bio är obligatorisk';
          }
          if (value.length > 300) {
            return 'Bio får inte vara längre än 300 tecken';
          }
          return null;
        },
        // The  form is saved and we tell what to do with the value
        onChanged: (String value) {
          setState(() {
            _userBio = value;
          });
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
        ),
        title: Image.asset('assets/images/uuLogaNew.png', fit: BoxFit.cover),
        centerTitle: true,
        backgroundColor: Colors.red.shade900,
        brightness: Brightness.light,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_rounded),
          onPressed: () {
            Navigator.pop(context);
          },
          tooltip: 'Tillbaka',
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          margin: EdgeInsets.only(top: 60, bottom: 20),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Redigera profil',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 40,
                    color: Colors.black,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                _buildName(),
                Padding(
                  padding: EdgeInsets.only(top: 12),
                ),
                _buildEmail(),
                Padding(
                  padding: EdgeInsets.only(top: 12),
                ),
                _buildNumber(),
                Padding(
                  padding: EdgeInsets.only(top: 12),
                ),
                _buildPassword(),
                Padding(
                  padding: EdgeInsets.only(top: 12),
                ),
                _checkUserPassword(),
                Padding(
                  padding: EdgeInsets.only(top: 12),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 12),
                ),
                _buildBio(),
                // adding space
                SizedBox(
                  height: 12,
                ),
                Padding(
                  padding: EdgeInsets.only(top: 12),
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.green[400],
                      padding:
                          EdgeInsets.symmetric(horizontal: 90, vertical: 15),
                    ),
                    child: Text(
                      'Spara',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 21,
                      ),
                    ),
                    onPressed: () async {
                      if (_formKey.currentState.validate()) {
                        // If the form is valid, onSaved method is called
                        // onsave method from above is called
                        _formKey.currentState.save();

                        // Check if the user has changed password
                        if (_changePassword) {
                          try {
                            final result = await locator
                                .get<AuthService>()
                                .updatePassword(_userPassword);
                            setState(() => _msgShown = 'Ändring sparades');
                          } on FirebaseAuthException catch (e) {
                            setState(() {
                              _msgShown = ErrorMessage(errorMsg: e.code)
                                  .erroMessageEditProfile();
                            });
                          }
                        }
                        // Checks if the user has changed the email
                        if (_changeEmail == true) {
                          try {
                            final result = await locator
                                .get<AuthService>()
                                .updateEmail(_userEmail);
                            setState(() => _msgShown = 'Ändring sparades');
                          } on FirebaseAuthException catch (e) {
                            setState(() {
                              _msgShown = ErrorMessage(errorMsg: e.code)
                                  .erroMessageEditProfile();
                            });
                          }
                        }
                        // Updates user information in the database
                        try {
                          await locator.get<DatabaseService>().updateUserData(
                                _userID,
                                _userName,
                                _userNumber,
                                _userBio,
                              );
                          setState(() => _msgShown = 'Ändring sparades');
                          //Navigator.pop(context);
                        } on FirebaseException catch (e) {
                          _msgShown = ErrorMessage(errorMsg: e.code)
                              .erroMessageEditProfile();
                        }
                      }
                    }),
                SizedBox(
                  height: 12,
                ),
                Text(
                  _msgShown,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.red, fontSize: 16),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: TextButton(
                    child: Text(
                      'Radera konto',
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                          decoration: TextDecoration.underline),
                    ),
                    onPressed: () async {
                      final askQuestion = await Dialogs.dialogAction(
                          context, 'Är du säker?', 'Ja', 'Nej');
                      if (askQuestion == DialogAction.option1) {
                        try {
                          await locator
                              .get<AuthService>()
                              .deleteAccount(_userID, widget.userProfileImgUrl);
                          await _firebaseAuth.signOutUser();
                          Navigator.of(context).pop();
                          Navigator.of(context).pop();
                        } on FirebaseAuthException catch (e) {
                          setState(() {
                            print(e);
                            _errorMsgDeleteAccount =
                                ErrorMessage(errorMsg: e.code)
                                    .erroMessageEditProfile();
                          });
                        }
                      } else if (askQuestion == DialogAction.option2) {}
                    },
                  ),
                ),
                Text(
                  _errorMsgDeleteAccount,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.red, fontSize: 16),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
