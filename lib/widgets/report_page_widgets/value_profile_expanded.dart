import 'package:flutter/material.dart';

class ValueProfileExpanded extends StatelessWidget {
  final IconData icon;
  final String label;

  ValueProfileExpanded({this.icon,this.label});

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
          width: 120,
          decoration: BoxDecoration(
              border: Border(bottom: BorderSide(width: 1.0, color: Color(0xFFEBEEF1)),)
          ),
          child: Text(label,
            style: TextStyle(
              color: Colors.black45,
              fontSize: 14.0,),),
        ),
      ],
    );
  }
}
