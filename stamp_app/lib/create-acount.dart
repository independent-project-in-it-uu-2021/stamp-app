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

  // key to hold the state of the form i.e referens to the form
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Widget _buildName() {
    return TextFormField(
      // Decorate the input field here
      decoration: InputDecoration(labelText: 'Förnamn Efternamn'),
      // The acutal value from the input
      validator: (String value) {
        if (value.isEmpty) {
          return 'namn är obligatorisk';
        }
      },
      // The  form is saved and we tell what to do with the value
      onSaved: (String value) {
        _fullName = value;
      },
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
                  height: 100,
                ),
                _buildName(),
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

/*class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
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
          child: Text(
            'Registrera Konto',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 40,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}*/
