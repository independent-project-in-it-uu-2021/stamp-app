import 'package:flutter/material.dart';

import 'package:stamp_app/models/user.dart';
import 'package:stamp_app/services/database.dart';
import 'package:stamp_app/services/locator.dart';
import 'package:stamp_app/sharedWidget/loadingScreen.dart';

class ManageAccounts extends StatefulWidget {
  @override
  _ManageAccountsState createState() => _ManageAccountsState();
}

class _ManageAccountsState extends State<ManageAccounts> {
  List<UserData> allUser;

  Widget _userProfilePic(String imageUrl) {
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
      print('inside newtworkImage');
      return CircleAvatar(
          backgroundImage: NetworkImage(imageUrl),
          minRadius: 20,
          maxRadius: 40,
          backgroundColor: Colors.white);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder(
        future: locator.get<DatabaseService>().getAllUsers(),
        builder: (BuildContext context, snapshot) {
          if (snapshot.hasData) {
            return Scaffold(
              appBar: AppBar(
                title: Image.asset('assets/images/uuLogaNew.png',
                    fit: BoxFit.cover),
                centerTitle: true,
                backgroundColor: Colors.red.shade900,
                elevation: 0,
                leading: IconButton(
                  icon: Icon(Icons.arrow_back_ios_rounded),
                  onPressed: () => Navigator.of(context).pop(),
                  tooltip: 'Tillbaka',
                ),
              ),
              body: ListView.builder(
                  itemCount: locator.get<DatabaseService>().allUsersCount,
                  itemExtent: MediaQuery.of(context).size.height * 0.1,
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                      child: ListTile(
                        contentPadding: EdgeInsets.only(top: 10),
                        leading: _userProfilePic(snapshot.data[index].imageUrl),
                        title: Text(snapshot.data[index].name),
                      ),
                    );
                  }),
            );
          } else {
            return LoadingScreen();
          }
        },
      ),
    );

    //List<UserData> _allUsers = [];
    //final allUsers = locator.get<DatabaseService>().getAllUsers();
    /*return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Image.asset('assets/images/uuLogaNew.png', fit: BoxFit.cover),
        centerTitle: true,
        backgroundColor: Colors.red.shade900,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_rounded),
          onPressed: () => Navigator.of(context).pop(),
          tooltip: 'Tillbaka',
        ),
      ),
      body: //Text('body'),
          ListView.builder(
              itemCount: locator.get<DatabaseService>().allUsersCount,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  child: ListTile(
                    leading: Image.network(allUser[index].imageUrl),
                    //title: Text(_allUsers[index].userName),
                  ),
                );
              }),
    );*/
  }
}
