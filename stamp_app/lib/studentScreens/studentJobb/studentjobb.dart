import 'package:flutter/material.dart';
import 'package:stamp_app/screens/editProfile/redigera-konto.dart';
import 'package:stamp_app/screens/val/val.dart';
import 'package:stamp_app/studentScreens/visaJobb/visaJobb.dart';
import 'package:stamp_app/studentScreens/studentIntresse/studentIntresse.dart';
import 'package:stamp_app/services/auth.dart';

class StudentWork extends StatelessWidget {
  final AuthService _firebaseAuth = AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Jobb'),
        backgroundColor: Colors.red.shade900,
        /*actions: <Widget>[
          IconButton(
            padding: EdgeInsets.only(right: 10),
            onPressed: null,
            icon: Icon(
              Icons.chat_bubble_rounded,
              color: Colors.white,
              size: 35,
            ),
          ),
        ],*/
      ),
      body: Container(
        width: double.infinity,
        child: SingleChildScrollView(
          child: Form(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 10),
                ),
                Text(
                  'Dina Jobb',
                  style: TextStyle(
                    fontSize: 30,
                    color: Colors.black,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.001,
                    width: MediaQuery.of(context).size.width * 0.83,
                    color: Colors.black12,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 30),
                ),
                /*TextButton(
                  style: TextButton.styleFrom(
                    textStyle: const TextStyle(fontSize: 30),
                    primary: Colors.black,
                  ),
                  onPressed: () => {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ShowWork()),
                    )
                  },
                  child: Row(
                    children: [
                      Padding(padding: EdgeInsets.only(left: 30)),
                      Icon(
                        Icons.smart_toy,
                        size: 70,
                      ),
                      Padding(padding: EdgeInsets.only(left: 20)),
                      Column(
                        children: [
                          Text(
                            'Lego workshop',
                            style: TextStyle(
                              fontSize: 30,
                              color: Colors.black,
                            ),
                          ),
                          Text(
                            '2021-07-11',
                            style: TextStyle(fontSize: 20),
                            textAlign: TextAlign.left,
                          ),
                          Text(
                            '13:00 - 15:00',
                            style: TextStyle(fontSize: 20),
                          ),
                          Text(
                            'Uppsala',
                            style: TextStyle(fontSize: 20),
                          ),
                          Text(
                            'Reserv',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.red.shade900,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),*/
                Padding(
                  padding: EdgeInsets.only(top: 10),
                ),
                /*Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.001,
                    width: MediaQuery.of(context).size.width * 0.83,
                    color: Colors.black12,
                  ),
                ),*/
                Padding(
                  padding: EdgeInsets.only(top: 10),
                ),
                /*TextButton(
                  style: TextButton.styleFrom(
                    textStyle: const TextStyle(fontSize: 30),
                    primary: Colors.black,
                  ),
                  onPressed: () => {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ShowWork()),
                    )
                  },
                  child: Row(
                    children: [
                      Padding(padding: EdgeInsets.only(left: 30)),
                      Icon(
                        Icons.smart_toy,
                        size: 70,
                      ),
                      Padding(padding: EdgeInsets.only(left: 20)),
                      Column(
                        children: [
                          Text(
                            'Lego workshop',
                            style: TextStyle(
                              fontSize: 30,
                              color: Colors.black,
                            ),
                          ),
                          Text(
                            '2021-07-11',
                            style: TextStyle(fontSize: 20),
                            textAlign: TextAlign.left,
                          ),
                          Text(
                            '13:00 - 15:00',
                            style: TextStyle(fontSize: 20),
                          ),
                          Text(
                            'Uppsala',
                            style: TextStyle(fontSize: 20),
                          ),
                          Text(
                            'Anmäld',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),*/
                Padding(
                  padding: EdgeInsets.only(top: 10),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.001,
                    width: MediaQuery.of(context).size.width * 0.83,
                    color: Colors.black12,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 30),
                ),
                Text(
                  'Lediga Jobb',
                  style: TextStyle(
                    fontSize: 30,
                    color: Colors.black,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 30),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.001,
                    width: MediaQuery.of(context).size.width * 0.83,
                    color: Colors.black12,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 30),
                ),
                /*TextButton(
                  style: TextButton.styleFrom(
                    textStyle: const TextStyle(fontSize: 30),
                    primary: Colors.black,
                  ),
                  onPressed: () => {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => StudentChoice()),
                    )
                  },
                  child: Row(
                    children: [
                      Padding(padding: EdgeInsets.only(left: 30)),
                      Icon(
                        Icons.smart_toy,
                        size: 70,
                      ),
                      Padding(padding: EdgeInsets.only(left: 20)),
                      Column(
                        children: [
                          Text(
                            'Lego workshop',
                            style: TextStyle(
                              fontSize: 30,
                              color: Colors.black,
                            ),
                          ),
                          Text(
                            '2021-07-11',
                            style: TextStyle(fontSize: 20),
                            textAlign: TextAlign.left,
                          ),
                          Text(
                            '13:00 - 15:00',
                            style: TextStyle(fontSize: 20),
                          ),
                          Text(
                            'Uppsala',
                            style: TextStyle(fontSize: 20),
                          ),
                          Text(
                            '3/4',
                            style: TextStyle(
                              fontSize: 20,
                              
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),*/
                Padding(
                  padding: EdgeInsets.only(top: 10),
                ),
                /*Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.001,
                    width: MediaQuery.of(context).size.width * 0.83,
                    color: Colors.black12,
                  ),
                ),*/
                /*Padding(
                  padding: EdgeInsets.only(top: 10),
                ),*/
                /*TextButton(
                  style: TextButton.styleFrom(
                    textStyle: const TextStyle(fontSize: 30),
                    primary: Colors.black,
                  ),
                  onPressed: () => {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => StudentChoice()),
                    )
                  },
                  child: Row(
                    children: [
                      Padding(padding: EdgeInsets.only(left: 30)),
                      Icon(
                        Icons.smart_toy,
                        size: 70,
                      ),
                      Padding(padding: EdgeInsets.only(left: 20)),
                      Column(
                        children: [
                          Text(
                            'Lego workshop',
                            style: TextStyle(
                              fontSize: 30,
                              color: Colors.black,
                            ),
                          ),
                          Text(
                            '2021-07-11',
                            style: TextStyle(fontSize: 20),
                            textAlign: TextAlign.left,
                          ),
                          Text(
                            '13:00 - 15:00',
                            style: TextStyle(fontSize: 20),
                          ),
                          Text(
                            'Uppsala',
                            style: TextStyle(fontSize: 20),
                          ),
                          Text(
                            '3/4',
                            style: TextStyle(
                              fontSize: 20,
                              
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),*/
                /*Padding(
                  padding: EdgeInsets.only(top: 10),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 30),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.001,
                    width: MediaQuery.of(context).size.width * 0.83,
                    color: Colors.black12,
                  ),
                ),*/
              ],
            ),
          ),
        ),
      ),
    );
  }
}
