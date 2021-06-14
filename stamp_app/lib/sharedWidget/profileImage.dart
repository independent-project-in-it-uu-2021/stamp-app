import 'package:flutter/material.dart';

class ProfileImage extends StatefulWidget {
  final String profileImagUrl;
  const ProfileImage({this.profileImagUrl});

  @override
  ProfileImageState createState() => ProfileImageState();
}

class ProfileImageState extends State<ProfileImage> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      //height: 115,
      //width: 115,
      child: Stack(
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(widget.profileImagUrl),
            minRadius: 60,
            maxRadius: 80,
          ),
          Positioned(
            bottom: 0,
            right: -25,
            child: RawMaterialButton(
              elevation: 2.0,
              fillColor: Colors.redAccent.shade700,
              child: Icon(
                Icons.camera_alt_outlined,
                color: Colors.white,
                //ize: 10,
              ),
              padding: EdgeInsets.all(7.0),
              shape: CircleBorder(),
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }
}
