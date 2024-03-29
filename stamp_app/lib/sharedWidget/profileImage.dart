import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:stamp_app/services/database.dart';
import 'dart:io';

import 'package:stamp_app/services/storage.dart';
import 'package:stamp_app/sharedWidget/dialogWidget.dart';
import 'package:stamp_app/services/locator.dart';

class ProfileImage extends StatefulWidget {
  final String profileImagUrl;
  const ProfileImage({this.profileImagUrl});

  @override
  ProfileImageState createState() => ProfileImageState();
}

class ProfileImageState extends State<ProfileImage> {
  PickedFile _pickedImage;
  File _newImage;

  // Show an icon if user has no profile pic otherwise
  // the profile image
  Widget _imageWidget() {
    if (widget.profileImagUrl == 'noImage') {
      return CircleAvatar(
          child: LayoutBuilder(
            builder: (context, constraints) {
              return Icon(
                Icons.account_circle,
                size: constraints.biggest.height,
                color: Colors.black,
              );
            },
          ),
          minRadius: 60,
          maxRadius: 80,
          backgroundColor: Colors.white);
    } else {
      return CircleAvatar(
          backgroundImage: NetworkImage(widget.profileImagUrl),
          minRadius: 60,
          maxRadius: 80,
          backgroundColor: Colors.white);
    }
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData _mediQuearyData = MediaQuery.of(context);
    final currentUser = Provider.of<User>(context);
    return SizedBox(
      child: Stack(
        children: [
          // Show an icon if user has no profile pic otherwise
          // the profile image
          _imageWidget(),
          Positioned(
            bottom: 0,
            right: _mediQuearyData.size.width * -0.06,
            child: RawMaterialButton(
              elevation: 2.0,
              fillColor: Colors.redAccent.shade700,
              child: Icon(
                Icons.camera_alt_outlined,
                color: Colors.white,
                //size: 10,
              ),
              padding: EdgeInsets.all(7.0),
              shape: CircleBorder(),
              onPressed: () async {
                final userOption = await Dialogs.dialogAction(
                    context, 'Profilbild (Frivillig)', 'Från mobil', 'Ta bild');
                if (userOption == DialogAction.option1) {
                  try {
                    _pickedImage = await ImagePicker()
                        .getImage(source: ImageSource.gallery);
                    _newImage = File(_pickedImage.path);

                    final imageUrl = await locator
                        .get<StorageServices>()
                        .deleteAndUploadImg(widget.profileImagUrl, _newImage);

                    await locator
                        .get<DatabaseService>()
                        .updateProfileImgUrl(currentUser.uid, imageUrl);
                  } catch (e) {
                    print(e);
                  }
                } else {
                  //TODO: Test this
                  try {
                    _pickedImage = await ImagePicker()
                        .getImage(source: ImageSource.camera);
                    _newImage = File(_pickedImage.path);

                    final imageUrl = await locator
                        .get<StorageServices>()
                        .deleteAndUploadImg(widget.profileImagUrl, _newImage);

                    await locator
                        .get<DatabaseService>()
                        .updateProfileImgUrl(currentUser.uid, imageUrl);
                  } catch (e) {
                    print(e);
                  }
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
