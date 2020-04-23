import 'package:final_project/widgets/report_page_widgets/ui_profile_data.dart';
import 'package:flutter/material.dart';

import '../shared/media_query.dart';

class ProfileData extends StatelessWidget {
  final user;

  ProfileData({@required this.user});

  @override
  Widget build(BuildContext context) {
    return Container(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              UIProfileData(
                name: user['name'],
                department: user['department']['name'],
                birth: user['birth'],
                phone: user['phone'],
                email: user['email'],
                gender: user['gender']['gender'],
                bloodtype: user['bloodType']['type'],
                livingPartner: user['livingPartner'],
              ),
              SizedBox(height: displayHeight(context)*2,)
            ],
          )
    ));
  }
}