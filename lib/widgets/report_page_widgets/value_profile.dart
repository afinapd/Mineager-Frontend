import 'package:flutter/material.dart';

class ValueProfile extends StatelessWidget {
  final IconData icon;
  final String label;

  ValueProfile({this.icon, this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(left: 25),
          child: Icon(
            icon,
            color: Colors.black45,
          ),
        ),
        Container(
          padding: EdgeInsets.all(10),
          width: MediaQuery.of(context).size.width / 1.3,
          decoration: BoxDecoration(
              border: Border(
            bottom: BorderSide(width: 1.0, color: Color(0xFFEBEEF1)),
          )),
          child: Text(
            label,
            style: TextStyle(
              color: Colors.black45,
              fontSize: 14.0,
            ),
          ),
        ),
      ],
    );
  }
}
