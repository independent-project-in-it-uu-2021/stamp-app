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
  String _chosenProgram;
  // Boolean value use to hide the write bio option field
  bool _writeBio = false;

  void showWriteBio() {
    setState(() {
      _writeBio = !_writeBio;
    });
  }

  //final programList<String> = ['Elektroteknik', 'Energisystem', 'Industriell ekonomi'];

  // key to hold the state of the form i.e referens to the form
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // Function for the name
  Widget _buildName() {
    return Container(
      width: 350,
      child: TextFormField(
        keyboardType: TextInputType.name,
        // Decorate the input field here,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          hintText: 'Förnamn Efternamn',
          counterStyle: TextStyle(color: Colors.white),
          errorStyle: TextStyle(color: Colors.white),
        ),
        // The acutal value from the input
        validator: (String value) {
          if (value.isEmpty) {
            return 'Namn är obligatorisk';
          }
          if (value.length > 120) {
            //TODO: Change the text below
            return 'Namn får inte vara längre än 120 tecken';
          }
          return null;
        },
        // The  form is saved and we tell what to do with the value
        onSaved: (String value) {
          print(value);
          _fullName = value;
        },
      ),
    );
  }

  //TODO: Check if a email is already used
  Widget _buildEmail() {
    return Container(
      width: 350,
      child: TextFormField(
        keyboardType: TextInputType.emailAddress,
        //maxLength: 255,
        // Decorate the input field here,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          hintText: 'E-post',
          counterStyle: TextStyle(color: Colors.white),
          errorStyle: TextStyle(color: Colors.white),
        ),
        // The acutal value from the input
        validator: (String value) {
          if (value.isEmpty) {
            return 'E-post är obligatorisk';
          }
          if (value.length > 255) {
            //TODO: Change the text below
            return 'Mejladress får inte vara längre än 255 tecken';
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
          errorStyle: TextStyle(color: Colors.white),
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
        obscureText: true,
        enableSuggestions: false,
        autocorrect: false,
        // Decorate the input field here,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          hintText: 'Lösenord',
          counterStyle: TextStyle(color: Colors.white),
          errorStyle: TextStyle(color: Colors.white),
        ),
        // The acutal value from the input
        validator: (String value) {
          if (value.isEmpty) {
            return 'Lösenord är obligatorisk';
          }
          return null;
        },
        //TODO: Password requirements
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
        obscureText: true,
        enableSuggestions: false,
        autocorrect: false,
        keyboardType: TextInputType.visiblePassword,
        // Decorate the input field here,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          hintText: 'Upprepa lösenord',
          counterStyle: TextStyle(color: Colors.white),
          errorStyle: TextStyle(color: Colors.white),
        ),
        // The acutal value from the input
        validator: (String value) {
          if (value.isEmpty) {
            return 'Upprepa lösenord är obligatorisk';
          }
          if (value != _userPassword) {
            print('Value inside checkpassword');
            print(value);
            // TODO: Change the text below
            return 'Lösenord är inte samma';
          }
          return null;
        },
      ),
    );
  }

  Widget _program() {
    return Container(
      width: 350,
      height: 60,
      child: DropdownButtonFormField(
        //TODO: Change the position of the list to above
        items: <String>[
          'One',
          'Two',
          'Three',
          'Övrigt',
        ].map<DropdownMenuItem<String>>((String value) {
          return new DropdownMenuItem(
            value: value,
            child: Row(
              children: <Widget>[
                //TODO: Check with the grupp maybe change the icon
                Icon(Icons.arrow_right),
                Text(value),
              ],
            ),
          );
        }).toList(),
        onChanged: (String newValue) {
          print('Inside dropdown');
          print(newValue);
          if (newValue == 'Övrigt') {
            showWriteBio();
          } else {
            showWriteBio();
            _chosenProgram = newValue;
          }
        },
        decoration: InputDecoration(
            border: new OutlineInputBorder(
                borderRadius:
                    const BorderRadius.all(const Radius.circular(30.0))),
            contentPadding: EdgeInsets.only(left: 15, top: 15),
            errorStyle: TextStyle(color: Colors.white, fontSize: 13),
            filled: true,
            fillColor: Colors.white,
            hintText: 'Does this work',
            //TODO: Change the text below
            errorText: 'Vänligen välj en program'),
      ),
    );
  }

  Widget _buildBio() {
    return Container(
      width: 350,
      child: Visibility(
        visible: _writeBio,
        child: TextFormField(
          keyboardType: TextInputType.name,
          // Decorate the input field here,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,

            //TODO: Change the text below
            hintText: 'Din roll?',
            counterStyle: TextStyle(color: Colors.white),
            errorStyle: TextStyle(color: Colors.white),
          ),
          // The acutal value from the input
          validator: (String value) {
            if (value.isEmpty) {
              return 'Bio är obligatorisk';
            }
            if (value.length > 150) {
              //TODO: Change the text below
              return 'Bio får inte vara längre än 120 tecken';
            }
            return null;
          },
          // The  form is saved and we tell what to do with the value
          onSaved: (String value) {
            print('Inside _buildbio');
            print(value);
            print(_chosenProgram);
            _chosenProgram = value;
          },
        ),
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
          // TODO: Change this (Does nothing right now)
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
            mainAxisAlignment: MainAxisAlignment.start,
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
              _program(),
              Padding(
                padding: EdgeInsets.only(top: 12),
              ),
              _buildBio(),
              // adding space
              SizedBox(
                height: 12,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.green[400],
                  padding: EdgeInsets.symmetric(horizontal: 90, vertical: 15),
                ),
                child: Text(
                  'Registrera',
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
                    print(_fullName);
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
    );
  }
}
