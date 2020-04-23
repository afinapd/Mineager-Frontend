import 'package:final_project/widgets/shared/media_query.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PagingButton extends StatelessWidget {
  final Function increment;
  final Function decrement;
  final int page;

  PagingButton({@required this.increment, @required this.decrement, this.page});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          IconButton(
            icon: Icon(FontAwesomeIcons.stepBackward),
            onPressed: decrement,
            color: Colors.black45,
            iconSize: 15,
          ),
          Container(
            height: 25,
            width: displayWidth(context)*50,
            child : Text('${page + 1}',style: TextStyle(fontSize: 16, color: Colors.black45, ), textAlign: TextAlign.center,),
            decoration: BoxDecoration(
              border: Border.all(width: 1.0, color: Colors.black12,),
              borderRadius: BorderRadius.all(Radius.circular(15)),
            ),
          ),
          IconButton(
            icon: Icon(FontAwesomeIcons.stepForward),
            onPressed: increment,
            color: Colors.black45,
            iconSize: 15,
          ),
        ],
      ),
    );
  }
}
