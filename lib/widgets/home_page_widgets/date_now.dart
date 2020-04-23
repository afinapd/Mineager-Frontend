import 'package:final_project/widgets/shared/media_query.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateNow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: displayWidth(context) * 2,
      top: displayHeight(context) * 1,
      child: Text(
        '${DateFormat('EEEE, d MMM yyyy').format(DateTime.now())}',
        style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: 13),
      ),);
  }
}
