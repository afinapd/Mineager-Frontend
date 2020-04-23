import 'package:final_project/widgets/shared/media_query.dart';
import 'package:flutter/material.dart';

class FieldSearchName extends StatefulWidget {
  final Function onSubmitted;
  final TextEditingController controller;
  FieldSearchName({@required this.onSubmitted, @required this.controller});
  @override
  _FieldSearchNameState createState() => _FieldSearchNameState();
}

class _FieldSearchNameState extends State<FieldSearchName> {
  int page = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: Color(0xFFEBEEF1),
          ),
          height: 40.0,
          width: displayWidth(context) * 65,
          child: TextField(
            controller: widget.controller,
            minLines: 1,
            style: TextStyle(
              color: Colors.black45,
              fontFamily: 'OpenSans',
            ),
            onSubmitted: widget.onSubmitted,
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 6.0),
              prefixIcon: Icon(
                Icons.search,
                color: Colors.black45,
                size: 20,
              ),
              hintText: 'Search employee by name',
              hintStyle: TextStyle(color: Colors.black45, fontSize: 14),
            ),
          ),
        ),
      ],
    );
  }
}
