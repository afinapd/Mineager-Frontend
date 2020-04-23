import 'package:final_project/auth.dart';
import 'package:final_project/local/services/db_service.dart';
import 'package:final_project/widgets/shared/media_query.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class LogOutButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[
          FlatButton(
            child: Text(
              'Sign Out',
              style: TextStyle(
                  color: Color.fromRGBO(208, 52, 47, 1), fontSize: 15),
            ),
            onPressed: () async {
              await signOutGoogle();
              await dbService.deleteCurrentUser();
              Navigator.of(context).pushReplacementNamed('/');

              // pushNewScreen(
              //   context,
              //   screen: LoginPage(),
              //   platformSpecific: false,
              //   withNavBar: false,
              // );
            },
          ),
          SizedBox(height: displayHeight(context) * 8),
        ],
      ),
    );
  }
}
