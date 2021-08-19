import 'package:flutter/material.dart';

class IconForWorkFeed extends StatelessWidget {
  final String jobCategory;
  const IconForWorkFeed({@required this.jobCategory});

  // Returns different typ of icon depending on category
  Widget _buildCategoryIcon() {
    if (jobCategory != null && jobCategory.isNotEmpty) {
      return LayoutBuilder(builder: (context, constraints) {
        switch (jobCategory) {
          case 'Workshop':
            return Icon(
              Icons.construction_sharp,
              size: MediaQuery.of(context).size.height * 0.07,
              color: Colors.black,
            );
            break;
          case 'Lego workshop':
            return Icon(
              Icons.smart_toy,
              size: MediaQuery.of(context).size.height * 0.07,
              color: Colors.black,
            );
            break;
          case 'Studiebesök':
            return Icon(
              Icons.school,
              size: MediaQuery.of(context).size.height * 0.07,
              color: Colors.black,
            );
            break;
          default:
            return Icon(
              Icons.campaign_sharp,
              size: MediaQuery.of(context).size.height * 0.07,
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

  @override
  Widget build(BuildContext context) {
    return _buildCategoryIcon();
  }
}
