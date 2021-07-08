import 'package:flutter/material.dart';

class ListViewImage extends StatelessWidget {
  String imageUrl;
  ListViewImage({this.imageUrl});

  // Widget is used to show profile image or icon in listview
  // Is used when user is shown in a listview
  @override
  Widget build(BuildContext context) {
    if (imageUrl == null || imageUrl.isEmpty) {
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
          minRadius: 20,
          maxRadius: 40,
          backgroundColor: Colors.white);
    } else {
      return CircleAvatar(
          backgroundImage: NetworkImage(imageUrl),
          minRadius: 20,
          maxRadius: 40,
          backgroundColor: Colors.white);
    }
  }
}
