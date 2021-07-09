import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

import 'package:icon_picker/icon_picker.dart';
import 'package:stamp_app/services/database.dart';

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
  int _numbStudents;
  String _selectedDate = 'Välj datum';
  String _selectedTime = 'Välj starttid';
  String _selectedEndTime = 'Välj sluttid';
  String _icon;
  String _jobCategory = '';
  // Boolean value use to hide the write bio option field
  bool _writeBio = false;

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

  Future<void> _showEndTime() async {
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
        _selectedEndTime = result.format(context);
      });
    }
  }

  // key to hold the state of the form i.e referens to the form
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // Function for the name
  Widget _buildName() {
    return Container(
      width: 350,
      child: TextFormField(
        keyboardType: TextInputType.name,
        maxLength: 20,

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
          _location = value;
        },
      ),
    );
  }

  conv(ic) {
    _icon = ic.toString();
  }

  final Map<String, IconData> myIconCollection = {
    'standard': Icons.favorite,
    'hem': Icons.home,
    'android': Icons.android,
    'album': Icons.album,
    'snöflinga': Icons.ac_unit,
    'brev': Icons.local_post_office,
  };

  Widget _chooseIcon() {
    return Container(
      child: IconPicker(
        initialValue: 'standard',
        icon: Icon(Icons.apps),
        labelText: "Välj en ikon för jobbet",
        title: "Välj en ikon",
        cancelBtn: "Avbryt",
        enableSearch: true,
        searchHint: 'Sök ikon',
        iconCollection: myIconCollection,
        onChanged: (ic) => print(ic),
        onSaved: (ic) => conv(ic),
      ),
    );
  }

  DropdownMenuItem<String> hej = DropdownMenuItem(child: Text('Kategori'));

  Widget _chooseCategory() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      height: 40.0,
      alignment: Alignment.center,
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(
          border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(30.0))),
          filled: true,
          fillColor: Colors.black12,
          contentPadding: EdgeInsets.only(left: 8, right: 18),
        ),
        //value: 'Välj en kategori',
        icon: Icon(Icons.arrow_downward),
        iconSize: 20,
        isExpanded: true,
        hint: Align(
          alignment: Alignment.center,
          child: Text(
            'Välj en kategori',
            style: TextStyle(color: Colors.black),
          ),
        ),
        items: <String>[
          'Välj en kategori',
          'Workshop',
          'Lego workshop',
          'Studiebesök',
        ].map<DropdownMenuItem<String>>((String curValue) {
          return DropdownMenuItem<String>(
            value: curValue,
            child: Text(curValue),
          );
        }).toList(),

        onChanged: (String newValue) {
          setState(() {
            _jobCategory = newValue;
          });
        },
      ),
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
          return null;
        },
        // The  form is saved and we tell what to do with the value
        onSaved: (String value) {
          _numbStudents = int.parse(value); //TODO Save as int
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
                onChanged: (date) {}, onConfirm: (date) {
              if (date != null) {
                setState(() {
                  var formattedDate = "${date.day}-${date.month}-${date.year}";
                  _selectedDate = formattedDate.toString();
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

  Widget _buildEndTime() {
    return Container(
      width: 300,
      child: FlatButton(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15.0))),
        color: Colors.black12,
        onPressed: _showEndTime,
        child: Text(
          "$_selectedEndTime",
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
          margin: EdgeInsets.only(top: 20, bottom: 20),
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
                _buildEndTime(),
                Padding(
                  padding: EdgeInsets.only(top: 12),
                ),
                //_chooseIcon(),
                Padding(
                  padding: EdgeInsets.only(top: 12),
                ),
                _chooseCategory(),
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

                      //Adding the job to the databas collection
                      DatabaseService().createJob(
                          _name,
                          _location,
                          _desc,
                          _numbStudents,
                          _selectedDate,
                          _selectedTime,
                          _selectedEndTime,
                          _icon,
                          _jobCategory);
                    }
                    Navigator.pop(context);
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
