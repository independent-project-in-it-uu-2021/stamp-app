import 'package:flutter/material.dart';

import 'package:stamp_app/screens/createJob/create-job.dart';

class Jobs extends StatefulWidget {
  @override
  _JobsState createState() => _JobsState();
}

class _JobsState extends State<Jobs> {
  Widget build(BuildContext context) {
    return Container(
      child: TextButton(
          child: Text('Klicka här'),
          onPressed: () => {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => CreateJob()))
              }),
    );
  }
}
