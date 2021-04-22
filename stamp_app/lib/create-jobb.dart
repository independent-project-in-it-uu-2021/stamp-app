import 'package:flutter/material.dart';

class CreateJob extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => CreateJobbState();
}

class CreateJobbState extends State<CreateJob> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset('assets/images/uuLogaNew.png', fit: BoxFit.cover),
        centerTitle: true,
        backgroundColor: Colors.red.shade900,
        elevation: 0,
        actions: <Widget>[
          IconButton(
              //TODO: Change the chat icon according to the prototyp
              icon: const Icon(Icons.chat),
              iconSize: 38,
              //TODO: Chat button does nothing right now
              onPressed: () => {})
        ],
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_rounded),
          // TODO: Change this (Does nothing right now)
          onPressed: () => Navigator.of(context).pop(),
          tooltip: 'Tillbaka',
        ),
      ),
      body: Container(
        width: double.infinity,
        child: Form(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Skapa jobb',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 38,
                fontFamily: 'Roboto',
                //fontWeight: FontWeight.bold,
              ),
            )
          ],
        )),
      ),
    );
  }
}
