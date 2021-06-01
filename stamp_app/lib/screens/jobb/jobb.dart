import 'package:flutter/material.dart';
import 'package:stamp_app/screens/createJob/create-job.dart';
import 'package:stamp_app/screens/editProfile/redigera-konto.dart';
import 'package:stamp_app/screens/val/val.dart';
import 'package:stamp_app/services/auth.dart';

class Work extends StatelessWidget {
  final AuthService _firebaseAuth = AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Jobb'),
        backgroundColor: Colors.red.shade900,
        actions: <Widget>[
          IconButton(
            padding: EdgeInsets.only(right: 10),
            onPressed: null,
            icon: Icon(
              Icons.chat_bubble_rounded,
              color: Colors.white,
              size: 35,
            ),
          ),
        ],
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
                  'Kommande Jobb',
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
                TextButton(
                    style: TextButton.styleFrom(
                      textStyle: const TextStyle(fontSize: 30),
                      primary: Colors.black,
                    ),
                    onPressed: () => {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Choice()),
                          )
                        },
                    child: const Text('Jobb 1')),
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
                TextButton(
                    style: TextButton.styleFrom(
                      textStyle: const TextStyle(fontSize: 30),
                      primary: Colors.black,
                    ),
                    onPressed: () => {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Choice()),
                          )
                        },
                    child: const Text('Jobb 2')),
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
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FloatingActionButton(
              backgroundColor: Colors.red.shade900,
              foregroundColor: Colors.white,
              onPressed: () => {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CreateJob()),
                )
              },
              child: Icon(Icons.add),
            ),
            Padding(padding: EdgeInsets.only(bottom: 100))
          ],
        ),
      ),
    );
  }
}
