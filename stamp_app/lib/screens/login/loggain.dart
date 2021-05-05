import 'package:flutter/material.dart';
import 'package:stamp_app/services/auth.dart';

class LogIn extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return LogInState();
  }
}

class LogInState extends State<LogIn> {
  // State parameter
  String _email;
  String _userPassword;

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
        maxLength: 255,
        //Decorate the input field here,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          hintText: 'E-post',
          counterStyle: TextStyle(color: Colors.white),
          errorStyle: TextStyle(
            color: Colors.white,
          ),
          //The actual value from the input
        ),
        validator: (String value) {
          if (value.isEmpty) {
            return 'E-post är obligatoriskt.';
          }
          if (!RegExp(
                  r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
              .hasMatch(value)) {
            return 'Ogiltig mejladress';
          }
          return null;
        },
        //The form is saved and we tell what to do with the value
        onSaved: (String value) {
          _email = value;
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
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          hintText: 'Lösenord',
          errorStyle: TextStyle(
            color: Colors.white,
          ),
          counterStyle: TextStyle(color: Colors.white),
        ),
        //The actual value from the input
        validator: (String value) {
          if (value.isEmpty) {
            return 'Lösenord är obligatoriskt';
          }
          return null;
        },
        //The form is saved and we tell what to do with the value
        onSaved: (String value) {
          _userPassword = value;
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red.shade900,
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
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50)),
                    color: Colors.white,
                    child: Text(
                      'Logga in',
                      style: TextStyle(color: Colors.black, fontSize: 28),
                    ),
                    onPressed: () async {
                      //if the form is not valid
                      if (!_formKey.currentState.validate()) {
                        return;
                      }
                      //If the form is valid, onSaved method is called
                      //onSave method from above is called
                      _formKey.currentState.save();
                      // login user returns either user of the error message
                      dynamic result = await _auth.signInAnon();
                      if (result == null) {
                        print('error logining in');
                      } else {
                        print('logged in');
                        print(result);
                      }
                    },
                  ),
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
                    onPressed: null,
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
