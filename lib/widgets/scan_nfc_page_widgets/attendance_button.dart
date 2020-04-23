import 'package:final_project/widgets/shared/media_query.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'nfc_button.dart';
import 'qr_button.dart';

class AttendanceButton extends StatefulWidget {
  final Function callback;
  String checkType = 'In';
  final currentState;
  AttendanceButton(
      {@required this.callback,
      @required this.checkType,
      @required this.currentState});
  @override
  _AttendanceButtonState createState() => _AttendanceButtonState();
}

class _AttendanceButtonState extends State<AttendanceButton> {
  String checkType = 'In';
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          SizedBox(
            height: displayHeight(context) * 10,
          ),
          Text(
            'Choose Attendance Method',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Color.fromRGBO(208, 52, 47, 1),
              fontSize: 20,
            ),
          ),
          SizedBox(
            height: displayHeight(context) * 4,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Check',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color.fromRGBO(208, 52, 47, 1),
                  fontSize: 16,
                ),
              ),
              SizedBox(
                width: 10,
              ),
              DropdownButton(
                onChanged: widget.callback,
                value: widget.checkType,
                items: [
                  DropdownMenuItem(
                    child: Text('IN',
                        style: TextStyle(color: Colors.black45, fontSize: 16)),
                    value: 'In',
                  ),
                  DropdownMenuItem(
                    child: Text('OUT',
                        style: TextStyle(color: Colors.black45, fontSize: 16)),
                    value: 'Out',
                  ),
                ],
              ),
            ],
          ),
          SizedBox(
            height: displayHeight(context) * 2,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              QRButton(
                currentState: widget.currentState,
              ),
              NFCButton(
                currentState: widget.currentState,
              )
            ],
          ),
          Container(
            height: displayHeight(context) * 30,
            decoration: BoxDecoration(
              color: Colors.white,
              image: DecorationImage(
                image: AssetImage(
                  "assets/example.png",
                ),
                fit: BoxFit.contain,
                alignment: Alignment.bottomCenter,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
