import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:stamp_app/models/user.dart';
import 'package:stamp_app/screens/annansProfil/annansProfil.dart';
import 'package:stamp_app/services/database.dart';
import 'package:stamp_app/services/locator.dart';
import 'package:stamp_app/sharedWidget/loadingScreen.dart';
import 'package:stamp_app/sharedWidget/imageForListView.dart';

class ManageAccounts extends StatefulWidget {
  @override
  _ManageAccountsState createState() => _ManageAccountsState();
}

class _ManageAccountsState extends State<ManageAccounts> {
  List<UserData> allUser;

  // Check if user has profileimage or not
  // returns userprofile image or icon
  Widget _userProfilePic(String imageUrl) {
    return ListViewImage(
      imageUrl: imageUrl,
    );
  }

  // Returns a container that is used to show the title
  Widget titleContainer(String title) {
    return Container(
      alignment: Alignment.topLeft,
      padding: EdgeInsets.fromLTRB(10, 5, 0, 10),
      child: Text(
        title,
        style: TextStyle(fontSize: 25),
        textAlign: TextAlign.left,
      ),
    );
  }

  // Elevated button widget that changes user roll
  // Shows a snackbar with msg as well
  Widget changeUserRoll(
      String userID, String currentRoll, String newRoll, String userName) {
    return ElevatedButton(
      onPressed: () async {
        String msgToShow = userName + ' byte roll';

        final changeRoll = await locator
            .get<DatabaseService>()
            .changeAccountRoll(userID, newRoll);

        setState(() {});

        // Snackbar design
        final snackBar = SnackBar(
          behavior: SnackBarBehavior.floating,
          padding: EdgeInsets.symmetric(horizontal: 8.0),
          content: Text(
            changeRoll == null ? msgToShow : 'Nånting gick fel',
            textAlign: TextAlign.center,
          ),
          backgroundColor: Colors.grey,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        );

        //Show Snackbar
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      },
      child: Text(currentRoll),
      style: ElevatedButton.styleFrom(primary: Colors.red.shade900),
    );
  }

  // Listview widget that is used to show user account
  // Call the changeUserRoll method,
  // Returs a ListViewbuilder widget
  Widget listViewForAccounts(
      List<UserData> usersAccountList, String currentRoll, String newRoll) {
    return ListView.builder(
        // User children total size
        // Cannot repeatedly scroll in more than one widget
        shrinkWrap: true,
        padding: EdgeInsets.only(bottom: 10),
        physics: NeverScrollableScrollPhysics(),
        itemCount: usersAccountList.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            child: ExpansionTile(
              leading: _userProfilePic(usersAccountList[index].imageUrl),
              title: Text(
                usersAccountList[index].name,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                usersAccountList[index].email,
              ),
              textColor: Colors.red.shade700,
              trailing: Icon(
                Icons.keyboard_arrow_down,
                color: Colors.grey,
              ),
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    // Eleveted button that changes user roll
                    changeUserRoll(usersAccountList[index].uid, currentRoll,
                        newRoll, usersAccountList[index].name),
                    SizedBox(
                      width: 6,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => OthersProfile(
                                userID: usersAccountList[index].uid),
                          ),
                        );
                      },
                      child: Text('Besök profile'),
                      style: ElevatedButton.styleFrom(
                          primary: Colors.red.shade900),
                    )
                  ],
                ),
              ],
            ),
          );
        });
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

                    // Inactive title
                    titleContainer('Inaktivera konto'),
                    // ListView for inactive accounts
                    listViewForAccounts(
                        inActiveUsers, 'Aktivera konto', 'student'),
                    // Admin title
                    titleContainer('Admin'),

                    //List view for admin account
                    listViewForAccounts(
                        adminUsers, 'Gör till student', 'student'),
                    // Student title
                    titleContainer('Student'),
                    //List view for student accounts
                    listViewForAccounts(
                        studentUsers, 'Gör till admin', 'admin'),
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
