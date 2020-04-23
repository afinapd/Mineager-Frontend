import 'package:final_project/widgets/shared/media_query.dart';
import 'package:flutter/material.dart';

class ErrorHandling extends StatelessWidget {
  final statusCode;
  final description;
  final routeClose;

  ErrorHandling({this.statusCode, this.description, this.routeClose});

  @override
  Widget build(BuildContext context) {
    return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        child: Center(
          child: Stack(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(
                  top: displayWidth(context) * 5,
                  bottom: displayWidth(context) * 10,
                  left: displayWidth(context) * 5,
                  right: displayHeight(context) * 3,
                ),
                margin: EdgeInsets.only(top: displayHeight(context) * 6),
                decoration: new BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 10.0,
                      offset: const Offset(0.0, 10.0),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min, // To make the card compact
                  children: <Widget>[
                    Image.asset('assets/error.gif'),
                    SizedBox(
                      height: displayHeight(context) * 5,
                    ),
                    Text(
                      'Oops Something went wrong !',
                      style: TextStyle(
                          fontSize: 22.0,
                          fontWeight: FontWeight.w700,
                          color: Color.fromRGBO(208, 52, 47, 1)),
                    ),
                    SizedBox(
                      height: displayHeight(context) * 2,
                    ),
                    Text(
                      statusCode != null
                          ? '$statusCode : $description'
                          : '$description',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w700,
                        color: Colors.black45,
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                right: displayWidth(context) * 0,
                top: displayHeight(context) * 10,
                child: FlatButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) => routeClose));
                  },
                  child: Icon(
                    Icons.close,
                    color: Colors.black45,
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
