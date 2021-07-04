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

  // Check if user has profileimage or not
  // returns userprofile image or icon
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
      return CircleAvatar(
          backgroundImage: NetworkImage(imageUrl),
          minRadius: 20,
          maxRadius: 40,
          backgroundColor: Colors.white);
    }
  }

  // Elevated button widget that changes user roll
  Widget changeUserRoll(String changeRollTO) {
    return ElevatedButton(
      onPressed: () async {},
      child: Text(changeRollTO),
      style: ElevatedButton.styleFrom(primary: Colors.red.shade900),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder(
        future: locator.get<DatabaseService>().getAllUsers(),
        builder: (BuildContext context, snapshot) {
          if (snapshot.hasData) {
            List<UserData> inActiveUsers = [];
            List<UserData> studentUsers = [];
            List<UserData> adminUsers = [];

            // Add user in different list depending on accounttype
            snapshot.data.forEach((currentUser) async {
              switch (currentUser.accountType) {
                case 'inactive':
                  inActiveUsers.add(currentUser);
                  break;
                case 'student':
                  studentUsers.add(currentUser);
                  break;
                case 'admin':
                  adminUsers.add(currentUser);
                  break;
              }
            });

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
              body: SingleChildScrollView(
                child: Column(
                  //Use Children total size
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                      alignment: Alignment.center,
                      child: Text(
                        'Konton',
                        style: TextStyle(fontSize: 35),
                      ),
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      padding: EdgeInsets.fromLTRB(10, 5, 0, 10),
                      child: Text(
                        'Inaktiverad konto',
                        style: TextStyle(fontSize: 25),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    // List view for accounts that are inactive
                    ListView.builder(
                        // User children total size
                        // Cannot repeatedly scroll in more than one widget
                        shrinkWrap: true,
                        padding: EdgeInsets.only(bottom: 10),
                        itemCount: inActiveUsers.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Card(
                            child: ExpansionTile(
                              leading: _userProfilePic(
                                  inActiveUsers[index].imageUrl),
                              title: Text(
                                inActiveUsers[index].name,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              subtitle: Text(
                                inActiveUsers[index].email,
                              ),
                              textColor: Colors.red.shade700,
                              trailing: Icon(
                                Icons.keyboard_arrow_down,
                                color: Colors.red,
                              ),
                              children: <Widget>[
                                ElevatedButton(
                                  onPressed: () {},
                                  child: Text('Gör till Admin'),
                                  //styleFrom static metho
                                  style: ElevatedButton.styleFrom(
                                      primary: Colors.red.shade900),
                                ),
                              ],
                            ),
                          );
                        }),
                    Container(
                      alignment: Alignment.topLeft,
                      padding: EdgeInsets.fromLTRB(10, 5, 0, 10),
                      child: Text(
                        'Admin',
                        style: TextStyle(fontSize: 30),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    //List view for admin account
                    ListView.builder(
                        // User children total size
                        // Cannot repeatedly scroll in more than one widget
                        shrinkWrap: true,
                        padding: EdgeInsets.only(bottom: 10),
                        itemCount: adminUsers.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Card(
                            child: ExpansionTile(
                              leading:
                                  _userProfilePic(adminUsers[index].imageUrl),
                              title: Text(
                                adminUsers[index].name,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              subtitle: Text(
                                adminUsers[index].email,
                              ),
                              textColor: Colors.red.shade700,
                              trailing: Icon(
                                Icons.keyboard_arrow_down,
                                color: Colors.red,
                              ),
                              children: <Widget>[
                                ElevatedButton(
                                  onPressed: () {},
                                  child: Text('Gör till Admin'),
                                  //styleFrom static metho
                                  style: ElevatedButton.styleFrom(
                                      primary: Colors.red.shade900),
                                ),
                              ],
                            ),
                          );
                        }),
                    Container(
                      alignment: Alignment.topLeft,
                      padding: EdgeInsets.fromLTRB(10, 5, 0, 10),
                      child: Text(
                        'Student',
                        style: TextStyle(fontSize: 30),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    //List view for student accounts
                    ListView.builder(
                        // User children total size
                        // Cannot repeatedly scroll in more than one widget
                        shrinkWrap: true,
                        itemCount: studentUsers.length,
                        padding: EdgeInsets.only(bottom: 10),
                        itemBuilder: (BuildContext context, int index) {
                          return Card(
                            child: ExpansionTile(
                              leading:
                                  // Method _userProfilePic is called that takes care
                                  // of cases when user has not profile image
                                  _userProfilePic(studentUsers[index].imageUrl),
                              title: Text(
                                studentUsers[index].name,
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              subtitle: Text(studentUsers[index].email),
                              textColor: Colors.red.shade700,
                              // TODO: Check red arrow och grey arrow??
                              /*trailing: Icon(
                                Icons.keyboard_arrow_down,
                                color: Colors.red,
                              ),*/
                              children: <Widget>[
                                ElevatedButton(
                                  onPressed: () {},
                                  child: Text('Gör till Admin'),
                                  //styleFrom static metho
                                  style: ElevatedButton.styleFrom(
                                      primary: Colors.red.shade900),
                                ),
                              ],
                            ),
                          );
                        }),
                  ],
                ),
              ),
            );
          } else {
            return LoadingScreen();
          }
        },
      ),
    );
  }
}
