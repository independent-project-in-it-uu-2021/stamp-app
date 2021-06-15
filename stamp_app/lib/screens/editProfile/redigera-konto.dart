import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:stamp_app/models/user.dart';
import 'package:stamp_app/sharedWidget/editProfileDecoration.dart';
import 'package:stamp_app/services/database.dart';
import 'package:stamp_app/sharedWidget/loadingScreen.dart';

class ProfileEdit extends StatefulWidget {
  final String userName;
  final String userNumber;
  final String userEmail;
  final String userBio;
  ProfileEdit({this.userName, this.userNumber, this.userEmail, this.userBio});
  @override
  State<StatefulWidget> createState() {
    return ProfileEditState();
  }
}

class ProfileEditState extends State<ProfileEdit> {
  // State parameter
  String _userName = '';
  String _userNumber = '';
  String _userEmail = '';
  String _userBio = '';
  String _userPassword = '';

  @override
  void initState() {
    super.initState();
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
          return null;
        },
        // The  form is saved and we tell what to do with the value
        onSaved: (String value) {
          _userEmail = value;
        },
      ),
    );
  }

  Widget _buildNumber() {
    return Container(
      width: 350,
      child: TextFormField(
        initialValue: widget.userNumber,
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
          if (value.isEmpty) {
            return 'Lösenord är obligatorisk';
          }
          return null;
        },
        //TODO: Password requirements
        // The  form is saved and we tell what to do with the value
        onChanged: (String value) {
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
          if (value.isEmpty) {
            return 'Upprepa lösenord är obligatorisk';
          } else if (value != _userPassword) {
            return 'Vänligen ange samma lösenord';
          } else if (value.length < 6) {
            return 'Lösenord behöver vara minst 6 tecken';
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
    //final currentUser = Provider.of<User>(context);
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
                    padding: EdgeInsets.symmetric(horizontal: 90, vertical: 15),
                  ),
                  child: Text(
                    'Spara',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 21,
                    ),
                  ),
                  onPressed: () {
                    // If the form is not valid

                    if (!_formKey.currentState.validate()) {
                      return;
                    }

                    // If the form is valid, onSaved method is called
                    // onsave method from above is called
                    if (_formKey.currentState.validate()) {
                      _formKey.currentState.save();
                    }

                    //print(_fullName);
                    //print(_email);
                    //print(_mobilnumber);
                    //print(_userPassword);
                    //print(_chosenProgram);
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
