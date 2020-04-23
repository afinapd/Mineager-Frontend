import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SearchBy extends StatelessWidget {
  final icon;
  final VoidCallback onPressed;
  SearchBy({@required this.icon, @required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        IconButton(
          icon: FaIcon(
            icon,
            color: Colors.black45,
            size: 30,
          ),
          onPressed: onPressed,
        ),
      ],
    );
  }
}
