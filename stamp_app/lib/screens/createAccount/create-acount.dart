import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:stamp_app/services/auth.dart';
import 'package:stamp_app/sharedWidget/inputDecoration.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';
import 'package:path/path.dart' as Path;
import 'package:file_picker/file_picker.dart';

class CreateAccount extends StatefulWidget {
  final Function toggleFunc;
  CreateAccount({this.toggleFunc});
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
  String _errorMsg = '';
  // Boolean value use to hide the write bio option field
  bool _writeBio = false;
  File _userImage;
  String _uploadedFileURL;

  // Authentication instance used to login
  final AuthService _auth = AuthService();

  Future _getImage() async {
    final pickedImage =
        await ImagePicker().getImage(source: ImageSource.gallery);
    setState(() {
      _userImage = File(pickedImage.path);
      print('_UserImage: $_userImage');
    });
  }

  Future __selectFile() async {
    final result = await FilePicker.platform.pickFiles(allowMultiple: false);

    if (result == null) return;
    final path = result.files.single.path;
    //setState(() => file = File(path));
    setState(() {
      _uploadedFileURL = File(path).toString();
    });
  }
  /*
  Future uploadFile() async {
    if (file ==null) return;
    final fileName = basename(file!.path);
    FirebaseApi.uploadFile(destination, file!);
*/

  /*
  Future __uploadFile() async {
    FirebaseStorage storage = FirebaseStorage.instance;
    Reference ref = storage.ref().child("getImage");
    UploadTask uploadTask = ref.putFile(_userImage);

    TaskSnapshot taskSnapshot = await uploadTask;
    taskSnapshot.ref.getDownloadURL().then(
          (value) => print("Done: $value"),
        );*/

  /*
      uploadTask.then((res) {
      res.ref.getDownloadURL();
      
    });
    */
/*
    await uploadTask.whenComplete(() {
      _uploadedFileURL = ref.getDownloadURL().toString();
    }).catchError((onError) {
      print(onError);
    });
    print(_uploadedFileURL);
    return _uploadedFileURL;
*/

/*
  Widget enableUpload(){
      return Container(
        child: Column(
          children: <Widget>[
            //Image.file(sampleImage, height: 300.0, width: 300.0)
            RaisedButton(
              elevation: 7.0,
              child: Text('Upload'),
              textColor: Colors.white,
              color: Colors.blue,
              onPressed: (){
                final firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance.ref().child('myimage.jpg');
                final firebase_storage.UploadTask task = firebaseStorageRef.putFile(_userImage); 
              },
            )
          ]          
        )
      )
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
  // this is a global form key
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // Function for the name
  /*Widget _buildName() {
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
        onChanged: (String value) {
          setState(() {
            _fullName = value;
          });
        },
      ),
    );
  }*/

  Widget _buildEmail() {
    return Container(
      width: 350,
      child: TextFormField(
        keyboardType: TextInputType.emailAddress,
        //maxLength: 255,
        // Decorate the input field here,
        decoration: textInputDecoration.copyWith(hintText: 'E-post'),
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
        onChanged: (String value) {
          setState(() {
            _email = value;
          });
        },
      ),
    );
  }

  /*Widget _buildNumber() {
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
        onChanged: (String value) {
          setState(() {
            _mobilnumber = value;
          });
        },
      ),
    );
  }*/

  Widget _buildPassword() {
    return Container(
      width: 350,
      child: TextFormField(
        keyboardType: TextInputType.visiblePassword,
        obscureText: true,
        enableSuggestions: false,
        autocorrect: false,
        // Decorate the input field here,
        decoration: textInputDecoration.copyWith(hintText: 'Lösenord'),
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
          setState(() {
            _userPassword = value;
          });
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
        // Decorate the input field here, textInputDecoration is called from inputDecoration.dart
        // textInputDecoration is used both here and in loggain.dart file. The decoration is the same.
        decoration: textInputDecoration.copyWith(hintText: 'Upprepa lösenord'),
        // The acutal value from the input
        validator: (String value) {
          if (value.isEmpty) {
            return 'Upprepa lösenord är obligatorisk';
          }
          if (value != _userPassword) {
            print('Value inside checkpassword');
            print(value);
            return 'Vänligen ange samma lösenord';
          }
          return null;
        },
      ),
    );
  }

  // Choose program from dropdown
  /*Widget _program() {
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
            //showWriteBio();
            setState(() {
              _chosenProgram = newValue;
            });
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
  }*/

  //Write bio if "Övrigt" is choosen in the dropdown meny
  /*Widget _buildBio() {
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
          onChanged: (String value) {
            setState(() {
              _chosenProgram = value;
            });
          },
        ),
      ),
    );
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red.shade900,
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
            widget.toggleFunc();
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
                /*_buildName(),
                Padding(
                  padding: EdgeInsets.only(top: 12),
                ),*/
                _buildEmail(),
                Padding(
                  padding: EdgeInsets.only(top: 12),
                ),
                /*_buildNumber(),
                Padding(
                  padding: EdgeInsets.only(top: 12),
                ),*/
                _buildPassword(),
                Padding(
                  padding: EdgeInsets.only(top: 12),
                ),
                _checkUserPassword(),
                Padding(
                  padding: EdgeInsets.only(top: 12),
                ),
                /*_program(),
                Padding(
                  padding: EdgeInsets.only(top: 12),
                ),
                _buildBio(),
                */
                // adding space
                SizedBox(
                  height: 12,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.white,
                    alignment: Alignment.center,
                    //padding: EdgeInsets.only(top: 10),
                  ),
                  child: Container(
                    height: 60,
                    width: 100,
                    margin: EdgeInsets.only(top: _changeMarginImage()),
                    child: _userImage == null
                        ? Text(
                            'Ladda upp profilbild',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          )
                        : Image.file(_userImage),
                  ),
                  onPressed: _getImage,
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
                    'Registrera',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 21,
                    ),
                  ),
                  onPressed: () async {
                    // If the form is not valid
                    if (!_formKey.currentState.validate()) {
                      print('Error: Form is not valid');
                    }

                    // If the form is valid, onSaved method is called
                    // onsave method from above is called
                    if (_formKey.currentState.validate()) {
                      dynamic result = await _auth.registerWithEmailAndPassword(
                          _email, _userPassword);
                      if (result == null) {
                        setState(() {
                          _errorMsg = 'Mejladressen används redan';
                        });
                      }
                    }
                    //__uploadImage();
                  },
                ),
                SizedBox(
                  height: 16,
                ),
                Text(
                  _errorMsg,
                  style: TextStyle(color: Colors.white, fontSize: 16),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
