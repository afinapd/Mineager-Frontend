import 'package:final_project/widgets/shared/media_query.dart';
import 'package:flutter/material.dart';

class NotificationText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        SizedBox(height: displayHeight(context)*15,),
        Image.asset('assets/error.gif'),
        SizedBox(
          height: displayHeight(context) * 5,
        ),
        Text(
          'Uh-oh. It appears you\'re offline !',
          style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.w700,
              color: Color.fromRGBO(208, 52, 47, 1)),
        ),
        SizedBox(height: displayHeight(context)*20,),
        // // LogOutButton()
      ],
    );
  }
}
