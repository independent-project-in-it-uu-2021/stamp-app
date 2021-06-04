import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

//import 'package:image_picker/image_picker.dart';
import 'dart:io';

class CreateJob extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return CreateJobState();
  }
}

class CreateJobState extends State<CreateJob> {
  // State parameter
  String _fullName;
  String _email;
  String _mobilnumber;
  String _userPassword;
  String _chosenProgram;
  // Boolean value use to hide the write bio option field
  bool _writeBio = false;

  File _userImage;
/*
  Future _getImage() async {
    final pickedImage =
        await ImagePicker().getImage(source: ImageSource.gallery);
    setState(() {
      _userImage = File(pickedImage.path);
      print('_UserImage: $_userImage');
    });
  }
*/
  // Method that is used to change the margin when an image is choosen
  double _changeMarginImage() {
    double curMargin;
    setState(() {
      /*
      same as if(_userImage == null){
        curMargin = 10;
      } else{
        curMargin = 0;
      }
      */
      curMargin = _userImage == null ? 10 : 0;
    });
    return curMargin;
  }

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
          fillColor: Colors.black12,
          hintText: 'Rubrik',
          counterStyle: TextStyle(color: Colors.red.shade900),
          errorStyle: TextStyle(color: Colors.red.shade900),
        ),
        // The acutal value from the input
        validator: (String value) {
          if (value.isEmpty) {
            return 'Rubrik är obligatorisk';
          }
          if (value.length > 120) {
            //TODO: Change the text below
            return 'Rubrik får inte vara längre än 120 tecken';
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

  Widget _buildPlace() {
    return Container(
      width: 350,
      child: TextFormField(
        keyboardType: TextInputType.name,
        // Decorate the input field here,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.black12,
          hintText: 'Plats',
          counterStyle: TextStyle(color: Colors.red.shade900),
          errorStyle: TextStyle(color: Colors.red.shade900),
        ),
        // The acutal value from the input
        validator: (String value) {
          if (value.isEmpty) {
            return 'Plats är obligatorisk';
          }
          if (value.length > 120) {
            //TODO: Change the text below
            return 'Plats får inte vara längre än 120 tecken';
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

  Widget _buildDate() {
    return Container(
      width: 350,
      child: TextFormField(
        keyboardType: TextInputType.name,
        // Decorate the input field here,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.black12,
          hintText: 'Datum',
          counterStyle: TextStyle(color: Colors.red.shade900),
          errorStyle: TextStyle(color: Colors.red.shade900),
        ),
        // The acutal value from the input
        validator: (String value) {
          if (value.isEmpty) {
            return 'Datum är obligatorisk';
          }
          if (value.length > 120) {
            //TODO: Change the text below
            return 'Datum får inte vara längre än 120 tecken';
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

  Widget _buildTime() {
    return Container(
      width: 350,
      child: TextFormField(
        keyboardType: TextInputType.name,
        // Decorate the input field here,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.black12,
          hintText: 'Tid',
          counterStyle: TextStyle(color: Colors.red.shade900),
          errorStyle: TextStyle(color: Colors.red.shade900),
        ),
        // The acutal value from the input
        validator: (String value) {
          if (value.isEmpty) {
            return 'Tid är obligatorisk';
          }
          if (value.length > 120) {
            //TODO: Change the text below
            return 'Tid får inte vara längre än 120 tecken';
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

  Widget _buildStudents() {
    return Container(
      width: 350,
      child: TextFormField(
        keyboardType: TextInputType.name,
        // Decorate the input field here,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.black12,
          hintText: 'Antal studenter',
          counterStyle: TextStyle(color: Colors.red.shade900),
          errorStyle: TextStyle(color: Colors.red.shade900),
        ),
        // The acutal value from the input
        validator: (String value) {
          if (value.isEmpty) {
            return 'Antal studenter är obligatorisk';
          }
          if (value.length > 120) {
            //TODO: Change the text below
            return 'Antal studenter får inte vara längre än 120 tecken';
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

  Widget _buildAbout() {
    return Container(
      width: 350,
      child: TextFormField(
        keyboardType: TextInputType.name,
        // Decorate the input field here,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.black12,
          hintText: 'Beskrivning',
          counterStyle: TextStyle(color: Colors.red.shade900),
          errorStyle: TextStyle(color: Colors.red.shade900),
        ),
        // The acutal value from the input
        validator: (String value) {
          if (value.isEmpty) {
            return 'Beskrivning är obligatorisk';
          }
          if (value.length > 500) {
            //TODO: Change the text below
            return 'Beskrivning får inte vara längre än 500 tecken';
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
          // TODO: Change this (Does nothing right now)
          onPressed: () {
            Navigator.pop(context);
          },
          tooltip: 'Tillbaka',
        ),
        /*actions: <Widget>[
          IconButton(
            padding: EdgeInsets.only(right: 10),
            onPressed: null,
            icon: Icon(
              Icons.chat_bubble_rounded,
              color: Colors.white,
              size: 35,
            ),
          ),
        ],*/
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
                  'Skapa jobb',
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
                _buildPlace(),
                Padding(
                  padding: EdgeInsets.only(top: 12),
                ),
                _buildDate(),
                Padding(
                  padding: EdgeInsets.only(top: 12),
                ),
                _buildAbout(),
                Padding(
                  padding: EdgeInsets.only(top: 12),
                ),
                _buildStudents(),
                Padding(
                  padding: EdgeInsets.only(top: 12),
                ),
                _buildTime(),
                Padding(
                  padding: EdgeInsets.only(top: 12),
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
                    'Bekräfta',
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
      ),
    );
  }
}
