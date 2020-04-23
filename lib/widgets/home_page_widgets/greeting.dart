import 'package:final_project/widgets/shared/media_query.dart';
import 'package:flutter/material.dart';

import '../../auth.dart';

class Greeting extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: displayHeight(context) * 2,
      top: displayHeight(context) * 30,
      child: Text(
        'Hello $name, Have a great day !',
        style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
            color: Colors.white),
      ),
    );
  }
}
