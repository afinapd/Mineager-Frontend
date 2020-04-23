import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../services/time_service.dart';
import 'title_profile.dart';
import 'value_profile.dart';
import 'value_profile_expanded.dart';

class UIProfileData extends StatelessWidget {
  final name;
  final department;
  final birth;
  final phone;
  final email;
  final gender;
  final bloodtype;
  final livingPartner;

  UIProfileData(
      {this.name,
      this.department,
      this.birth,
      this.phone,
      this.email,
      this.gender,
      this.livingPartner,
      this.bloodtype});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        TitleProfile(
          title: 'Name',
        ),
        ValueProfile(icon: Icons.person, label: name),
        TitleProfile(
          title: 'Department',
        ),
        ValueProfile(icon: Icons.person_pin_circle, label: department),
        TitleProfile(
          title: 'Birth of Date',
        ),
        ValueProfile(
            icon: Icons.cake, label: TimeService().beautifyDate(birth)),
        TitleProfile(
          title: 'Phone Number',
        ),
        ValueProfile(icon: Icons.phone, label: phone),
        TitleProfile(
          title: 'Email',
        ),
        ValueProfile(icon: Icons.email, label: email),
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  TitleProfile(
                    title: 'Gender',
                  ),
                  ValueProfileExpanded(
                    icon: FontAwesomeIcons.venusMars,
                    label: gender,
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  TitleProfile(
                    title: 'Blood Type',
                  ),
                  ValueProfileExpanded(
                    icon: FontAwesomeIcons.tint,
                    label: bloodtype,
                  ),
                ],
              ),
            ),
          ],
        ),
        TitleProfile(
          title: 'Living Partner',
        ),
        ValueProfile(
          icon: FontAwesomeIcons.building,
          label: livingPartner,
        ),
      ],
    );
  }
}
