import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ScanOrNFC extends StatelessWidget {
  final IconData icon;
  final String label;
  ScanOrNFC(this.icon, this.label);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      width: 120,
      child: Card(
        color: Colors.grey,
        elevation: 10,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FaIcon(
              icon,
              color: Colors.white,
              size: 50,
            ),
            SizedBox(
              height: 10,
            ),
            Text(label, style: TextStyle(color: Colors.white, fontSize: 18))
          ],
        ),
      ),
    );
  }
}
