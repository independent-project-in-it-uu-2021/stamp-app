import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';

import 'package:stamp_app/services/auth.dart';
import 'package:stamp_app/sharedWidget/inputDecoration.dart';
import 'package:stamp_app/sharedWidget/loadingScreen.dart';

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
  String _profileImageUrl;
  bool _useDefaultPic = true;
  String _defaultProfilePic =
      'https://firebasestorage.googleapis.com/v0/b/stamp-db6ad.appspot.com/o/userProfilePicture%2Fprofile-user.png?alt=media&token=170630ba-bccf-4bd7-b50b-9d5e08f01a73';
  String _defaultAccountStatue = 'inactive';
  File _userImage;
  bool loading = false;
  // Boolean value use to hide the write bio option field

  // Authentication instance used to login
  final AuthService _auth = AuthService();

  // Method that is used to change the margin when an image is choosen
  double _changeMarginImage() {
    double curMargin;
    setState(() {
      if (_userImage == null) {
        curMargin = 10;
      } else {
        curMargin = 0;
      }

      curMargin = _userImage == null ? 10 : 0;
    });
    return curMargin;
  }

  // Getting the image from the phone
  Future _getImage() async {
    final pickedImage =
        await ImagePicker().getImage(source: ImageSource.gallery);
    _useDefaultPic = false;
    setState(() {
      _userImage = File(pickedImage.path);
      print('_UserImage: $_userImage');
    });
  }

  //Upload the image to firebase storage
  Future uploadImage(BuildContext context) async {
    print('inside uploadImage');
    // Path of the picture
    String fileName = basename(_userImage.path);

    // Referene to the firebase storage or reference to the bucket
    Reference storageReference =
        FirebaseStorage.instance.ref().child('userProfilePicture/$fileName');

    // Put the file in the bucket above
    final UploadTask uploadTask = storageReference.putFile(_userImage);
    // Getting image url
    final TaskSnapshot downloadUrl = (await uploadTask);
    // Url of the file in the storagew
    final String imageUrl = await downloadUrl.ref.getDownloadURL();
    return imageUrl;
    print(imageUrl);
  }

  // key to hold the state of the form i.e referens to the form
  // this is a global form key
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // Function for the name
  Widget _buildName() {
    return Container(
      width: 350,
      child: TextFormField(
        keyboardType: TextInputType.name,
        // Decorate the input field here,
        decoration: textInputDecoration.copyWith(hintText: 'Förnamn Efternamn'),
        // The acutal value from the input
        validator: (String value) {
          if (value.isEmpty) {
            return 'Namn är obligatorisk';
          }
          if (value.length > 120) {
            return 'Namnet får inte vara längre än 120 tecken';
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
  }

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
            return 'Mejladressen får inte vara längre än 255 tecken';
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

  Widget _buildNumber() {
    return Container(
      width: 350,
      child: TextFormField(
        keyboardType: TextInputType.number,
        // Decorate the input field here,
        decoration:
            textInputDecoration.copyWith(hintText: 'Telefonnummer (Frivillig)'),
        // The  form is saved and we tell what to do with the value
        onChanged: (String value) {
          setState(() {
            _mobilnumber = value;
          });
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
        decoration: textInputDecoration.copyWith(hintText: 'Lösenord'),
        // The acutal value from the input
        validator: (String value) {
          if (value.isEmpty) {
            return 'Lösenord är obligatorisk';
          } else if (value.length < 6) {
            return 'Lösenord behöver vara minst 6 tecken';
          }
          return null;
        },
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
        keyboardType: TextInputType.name,
        maxLength: 300,
        // Decorate the input field here,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(15, 10, 0, 40),
          filled: true,
          fillColor: Colors.white,
          hintText: 'Kort bio',
          counterStyle: TextStyle(color: Colors.white),
          errorStyle: TextStyle(color: Colors.white),
        ),
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
            _chosenProgram = value;
          });
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? LoadingScreen()
        : Scaffold(
            backgroundColor: Colors.red.shade900,
            appBar: AppBar(
              systemOverlayStyle: SystemUiOverlayStyle(
                statusBarColor: Colors.transparent,
              ),
              title:
                  Image.asset('assets/images/uuLogaNew.png', fit: BoxFit.cover),
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
                      _buildBio(),
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
                          onPressed: () {
                            _getImage();
                          }),
                      Padding(
                        padding: EdgeInsets.only(top: 12),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.green[400],
                          padding: EdgeInsets.symmetric(
                              horizontal: 90, vertical: 15),
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
                            //Show loading screen
                            setState(() => loading = true);
                            _useDefaultPic
                                ? _profileImageUrl = _defaultProfilePic
                                : _profileImageUrl = await uploadImage(context);

                            dynamic result =
                                await _auth.registerWithEmailAndPassword(
                                    _email,
                                    _userPassword,
                                    _fullName,
                                    _mobilnumber,
                                    _chosenProgram,
                                    _profileImageUrl,
                                    _defaultAccountStatue);
                            print(result);
                            if (result == null) {
                              setState(() {
                                loading = false;
                                _errorMsg = 'Mejladressen används redan';
                              });
                            }
                          }
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
