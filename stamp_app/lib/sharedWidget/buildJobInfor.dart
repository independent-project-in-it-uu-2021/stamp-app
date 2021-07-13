import 'package:flutter/material.dart';

import 'package:stamp_app/models/jobsModel.dart';

class BuildJobInformation extends StatefulWidget {
  final Jobs curJob;

  BuildJobInformation({Key key, @required this.curJob}) : super(key: key);

  @override
  _BuildJobInformationState createState() => _BuildJobInformationState();
}

class _BuildJobInformationState extends State<BuildJobInformation> {
  // Job information attribute
  String jobID;
  String title;
  String description;
  String date;
  String time;
  String endTime;
  String location;
  int count;
  int maxCount;
  int reserveCount;
  String category;
  Map showInterestUser;
  int amountSelected;
  int amountReserved;

  @override
  void initState() {
    super.initState();
    jobID = widget.curJob.jobID;
    title = widget.curJob.title;
    description = widget.curJob.description;
    date = widget.curJob.date;
    time = widget.curJob.time;
    endTime = widget.curJob.endTime;
    location = widget.curJob.location;
    count = widget.curJob.count;
    maxCount = widget.curJob.maxCount;
    reserveCount = widget.curJob.reserveCount;
    category = widget.curJob.category;
    showInterestUser = widget.curJob.currentInterest;
    amountSelected = widget.curJob.count;
    amountReserved = widget.curJob.reserveCount;
  }

  // Returns different typ of icon depending on category
  Widget _buildCategoryIcon(String jobCategory) {
    if (jobCategory != null && jobCategory.isNotEmpty) {
      return LayoutBuilder(builder: (context, constraints) {
        switch (jobCategory) {
          case 'Workshop':
            return Icon(
              Icons.construction_sharp,
              size: MediaQuery.of(context).size.height * 0.09,
              color: Colors.black,
            );
            break;
          case 'Lego workshop':
            return Icon(
              Icons.smart_toy,
              size: MediaQuery.of(context).size.height * 0.09,
              color: Colors.black,
            );
            break;

          case 'Studiebesök':
            return Icon(
              Icons.school,
              size: MediaQuery.of(context).size.height * 0.09,
              color: Colors.black,
            );
            break;
          default:
            return Icon(
              Icons.campaign_sharp,
              size: MediaQuery.of(context).size.height * 0.09,
              color: Colors.black,
            );
        }
      });
    } else {
      return LayoutBuilder(builder: (context, constraints) {
        return Icon(
          Icons.campaign_sharp,
          size: MediaQuery.of(context).size.height * 0.07,
          color: Colors.black,
        );
      });
    }
  }

  Widget _buildJobInformation() {
    MediaQueryData screenSize = MediaQuery.of(context);
    return Column(
      children: [
        Row(
          children: [
            Padding(padding: EdgeInsets.only(left: 30)),
            _buildCategoryIcon(category),
            Padding(padding: EdgeInsets.only(left: 20)),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: screenSize.size.width * 0.6,
                  child: Text(
                    title,
                    style: TextStyle(
                      fontSize: screenSize.size.width * 0.055,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.left,
                    overflow: TextOverflow.clip,
                  ),
                ),
                Text('Tid: ' + time + '-' + endTime,
                    style: TextStyle(fontSize: 18), textAlign: TextAlign.left),
                Text('Datum: ' + date,
                    style: TextStyle(fontSize: 18), textAlign: TextAlign.left),
                Text(
                  'Studenter: ' +
                      count.toString() +
                      '/' +
                      maxCount.toString() +
                      ' st',
                  style: TextStyle(fontSize: 18),
                  textAlign: TextAlign.left,
                ),
                Text(
                  'Reserver: ' + reserveCount.toString() + ' st',
                  style: TextStyle(fontSize: 18),
                  textAlign: TextAlign.left,
                ),
              ],
            ),
            Padding(padding: EdgeInsets.only(left: 20)),
          ],
        ),
        Padding(padding: EdgeInsets.only(top: 20)),
        Row(
          children: [
            Padding(padding: EdgeInsets.only(left: 30)),
            Expanded(
              child: Text(
                description,
                style: TextStyle(fontSize: 14),
                textAlign: TextAlign.left,
                overflow: TextOverflow.ellipsis,
                maxLines: 10,
              ),
            ),
            Padding(padding: EdgeInsets.only(right: 10)),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData screenSize = MediaQuery.of(context);
    return _buildJobInformation();
  }
}
