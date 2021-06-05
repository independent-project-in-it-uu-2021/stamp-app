import 'dart:ui';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:stamp_app/screens/jobb/jobb.dart';
import 'package:flutter_iconpicker/flutter_iconpicker.dart';
import 'package:flutter_iconpicker/Serialization/iconDataSerialization.dart';
//import 'package:image_picker/image_picker.dart';

class CreateJob extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return CreateJobState();
  }
}

class CreateJobState extends State<CreateJob> {
  // State parameter
  String _name;
  String _location;
  String _desc;
  String _numbStudents;
  String _selectedDate = "Välj ett datum för jobbet";
  String _selectedTime = "Välj en tid för jobbet";
  int _icon;
  // Boolean value use to hide the write bio option field
  bool _writeBio = false;

  Future<void> _pickIcon() async {
    IconData icon = await FlutterIconPicker.showIconPicker(context,
        iconPackMode: IconPack.cupertino);

    setState(() {
      int ic = icon.codePoint;
      _icon = ic;
    });

    debugPrint('Picked Icon:  $icon');
  }

  Future<void> _show() async {
    final TimeOfDay result = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (BuildContext context, Widget child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
          child: child,
        );
      },
    );
    if (result != null) {
      setState(() {
        _selectedTime = result.format(context);
      });
    }
  }

  void showWriteBio() {
    setState(() {
      _writeBio = !_writeBio;
    });
  }

  // key to hold the state of the form i.e referens to the form
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // Function for the name
  Widget _buildName() {
    return Container(
      width: 350,
      child: TextFormField(
        keyboardType: TextInputType.name,
        maxLength: 50,

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
          _name = value;
        },
      ),
    );
  }

  Widget _buildPlace() {
    return Container(
      width: 350,
      child: TextFormField(
        keyboardType: TextInputType.name,
        maxLength: 50,

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
          _location = value;
        },
      ),
    );
  }

  Widget _chooseIcon() {
    return Container(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            RaisedButton(
              onPressed: _pickIcon,
              child: Text('Open Icon Picker'),
            ),
            SizedBox(height: 10),
            AnimatedSwitcher(
                duration: Duration(milliseconds: 300),
                child: _icon != null ? _icon : Container()),
          ]),
    );
  }

  Widget _buildStudents() {
    return Container(
      width: 350,
      child: TextFormField(
        keyboardType: TextInputType.number,
        inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
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
          _numbStudents = value; //TODO Save as int
        },
      ),
    );
  }

  Widget _buildAbout() {
    return Container(
      width: 350,
      child: TextFormField(
        // Decorate the input field here,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.black12,
          hintText: 'Beskrivning',
          counterStyle: TextStyle(color: Colors.red.shade900),
          errorStyle: TextStyle(color: Colors.red.shade900),
        ),
        keyboardType: TextInputType.multiline,
        maxLines: null,
        maxLength: 500,
        textAlignVertical: TextAlignVertical.top,
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
          _desc = value;
        },
      ),
    );
  }

  //Widget för att välja datum
  Widget _buildDate() {
    return Container(
        width: 300,
        child: FlatButton(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(15.0))),
          color: Colors.black12,
          onPressed: () {
            DatePicker.showDatePicker(context,
                showTitleActions: true,
                minTime: DateTime(DateTime.now().year - 5, 1, 1),
                maxTime: DateTime(DateTime.now().year + 5, 12, 31),
                onChanged: (date) {
              print('change $date');
            }, onConfirm: (date) {
              print('confirm $date');
              if (date != null) {
                setState(() {
                  var formattedDate = "${date.day}-${date.month}-${date.year}";
                  _selectedDate = formattedDate.toString();
                  print(date.toString());
                });
              }
            }, currentTime: DateTime.now(), locale: LocaleType.sv);
          },
          child: Text(
            "$_selectedDate",
            style: TextStyle(color: Colors.black),
          ),
        ));
  }

  //Widget för klockan med hjälp av _show
  Widget _buildTime() {
    return Container(
      width: 300,
      child: FlatButton(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15.0))),
        color: Colors.black12,
        onPressed: _show,
        child: Text(
          "$_selectedTime",
          style: TextStyle(color: Colors.black),
        ),
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
                _buildAbout(),
                Padding(
                  padding: EdgeInsets.only(top: 12),
                ),
                _buildStudents(),
                Padding(
                  padding: EdgeInsets.only(top: 12),
                ),
                _buildDate(),
                Padding(
                  padding: EdgeInsets.only(top: 12),
                ),
                _buildTime(),
                Padding(
                  padding: EdgeInsets.only(top: 12),
                ),
                _chooseIcon(),
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

                      FirebaseFirestore.instance.collection('jobs').add({
                        'jobName': _name,
                        'location': _location,
                        'description': _desc,
                        'numberOfStudents': _numbStudents,
                        'date': _selectedDate,
                        'time': _selectedTime,
                        'icon': _icon, //serializeIcon(_icon),
                      });
                    }
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Work()),
                    );
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
