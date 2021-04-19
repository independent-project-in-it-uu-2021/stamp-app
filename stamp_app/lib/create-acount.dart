import 'package:flutter/material.dart';

class CreateAccount extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return CreateAccountState();
  }
}

class CreateAccountState extends State<CreateAccount> {
  // State parameter
  String _fullName;
  String _email;
  String _mobilnumber;
  String _userPassword;

  // key to hold the state of the form i.e referens to the form
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Widget _buildName() {
    return Container(
      width: 350,
      child: TextFormField(
        keyboardType: TextInputType.name,
        maxLength: 40,
        // Decorate the input field here,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          hintText: 'Förnamn Efternamn',
          counterStyle: TextStyle(color: Colors.white),
        ),
        // The acutal value from the input
        validator: (String value) {
          if (value.isEmpty) {
            return 'Namn är obligatorisk';
          }
        },
        // The  form is saved and we tell what to do with the value
        onSaved: (String value) {
          _fullName = value;
        },
      ),
    );
  }

  Widget _buildEmail() {
    return Container(
      width: 350,
      child: TextFormField(
        keyboardType: TextInputType.emailAddress,
        maxLength: 40,
        // Decorate the input field here,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          hintText: 'E-post',
          counterStyle: TextStyle(color: Colors.white),
        ),
        // The acutal value from the input
        validator: (String value) {
          if (value.isEmpty) {
            return 'E-post är obligatorisk';
          }

          if (!RegExp(
                  r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
              .hasMatch(value)) {
            return 'Ogiltig mejladress';
          }
          return null;
        },
        // The  form is saved and we tell what to do with the value
        onSaved: (String value) {
          _email = value;
        },
      ),
    );
  }

  Widget _buildNumber() {
    return Container(
      width: 350,
      child: TextFormField(
        keyboardType: TextInputType.number,
        // Decorate the input field here,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          hintText: 'Telefonnummer (Frivilligt)',
          counterStyle: TextStyle(color: Colors.white),
        ),

        // The  form is saved and we tell what to do with the value
        onSaved: (String value) {
          _mobilnumber = value;
        },
      ),
    );
  }

  Widget _buildPassword() {
    return Container(
      width: 350,
      child: TextFormField(
        keyboardType: TextInputType.visiblePassword,
        // Decorate the input field here,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          hintText: 'Lösenord',
          counterStyle: TextStyle(color: Colors.white),
        ),
        // The acutal value from the input
        validator: (String value) {
          if (value.isEmpty) {
            return 'Lösenord är obligatorisk';
          }
          return null;
        },
        // The  form is saved and we tell what to do with the value
        onSaved: (String value) {
          _userPassword = value;
        },
      ),
    );
  }

  Widget _checkUserPassword() {
    return Container(
      width: 350,
      child: TextFormField(
        keyboardType: TextInputType.visiblePassword,
        // Decorate the input field here,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          hintText: 'Upprepa lösenord',
          counterStyle: TextStyle(color: Colors.white),
        ),
        // The acutal value from the input
        validator: (String value) {
          if (value.isEmpty) {
            return 'Upprepa lösenord är obligatorisk';
          }
          if (value != _userPassword) {
            // TODO: Change the text below
            return 'Lösenord är samma';
          }
          return null;
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
          // TODO: Change this
          onPressed: () => Navigator.of(context).pop(),
          tooltip: 'Tillbaka',
        ),
      ),
      body: Container(
          width: double.infinity,
          margin: EdgeInsets.only(top: 60, bottom: 20),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Registrera Konto',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 40,
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                _buildName(),
                _buildEmail(),
                _buildNumber(),
                Padding(
                  padding: EdgeInsets.only(top: 20),
                ),
                _buildPassword(),
                Padding(
                  padding: EdgeInsets.only(top: 20),
                ),
                _checkUserPassword(),
                // adding space
                SizedBox(
                  height: 100,
                ),
                RaisedButton(
                  child: Text(
                    'Submit',
                    style: TextStyle(color: Colors.blue),
                  ),
                  onPressed: () {
                    // If the form is not valid
                    if (!_formKey.currentState.validate()) {
                      return;
                    }

                    // If the form is valid, onSaved method is called
                    // onsave method from above is called
                    _formKey.currentState.save();
                    print(_fullName);
                  },
                )
              ],
            ),
          )
          /*Text(
          'Registrera Konto',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 40,
            color: Colors.white,
          ),
        ),*/
          ),
    );
  }
}
