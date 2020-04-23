import 'package:final_project/app_bar.dart';
import 'package:final_project/blocs/bloc_event.dart';
import 'package:final_project/blocs/bloc_state.dart';
import 'package:final_project/blocs/scan_nfc_page_bloc.dart';
import 'package:final_project/constant/constants.dart';
import 'package:final_project/pages/scan_nfc_page.dart';
import 'package:final_project/services/time_service.dart';
import 'package:final_project/widgets/shared/media_query.dart';
import 'package:final_project/widgets/scan_nfc_page_widgets/value_profile.dart';
import 'package:final_project/widgets/shared/error_handling.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomDialog extends StatelessWidget {
  final data;
  final absType;
  final currentState;
  CustomDialog(this.data, this.absType, this.currentState);

  dialogContent(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(
            top: displayWidth(context) * 18,
            bottom: displayWidth(context) * 2,
            left: displayWidth(context) * 5,
            right: displayHeight(context) * 3,
          ),
          margin: EdgeInsets.only(top: displayHeight(context) * 10),
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
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                data['name'],
                style: TextStyle(
                  fontSize: 24.0,
                  color: Color.fromRGBO(208, 52, 47, 1),
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(
                height: displayHeight(context) * 2,
              ),
              ValueProfile(
                  icon: Icons.person_pin_circle,
                  label: data['department']['name']),
              ValueProfile(icon: Icons.phone, label: data['phone']),
              ValueProfile(icon: Icons.email, label: data['email']),
              ValueProfile(
                  icon: FontAwesomeIcons.tint,
                  label: data['bloodType']['type']),
              SizedBox(
                height: displayHeight(context) * 2,
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: FlatButton(
                  onPressed: () {
                    {
                      if (absType == 'In') {
                        BlocProvider.of<ScanNfcPageBloc>(context)
                            .add(SubmitAttendance(
                          data['id'],
                          TimeService().getDate(),
                          TimeService().getTime(),
                          currentState,
                        ));
                      } else {
                        BlocProvider.of<ScanNfcPageBloc>(context).add(CheckOut(
                            data['id'], TimeService().getTime(), currentState));
                      }
                    }
                  },
                  child: Text(
                    'Submit',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w700,
                      color: Colors.black45,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Positioned(
          top: displayHeight(context) * 4,
          left: displayWidth(context) * 26,
          child: Center(
            child: CircleAvatar(
              backgroundColor: Colors.grey,
              radius: 50,
              backgroundImage: data['image'] != null
                  ? NetworkImage('$API/${data['image']['path']}')
                  : AssetImage('assets/no_avatar.jpg'),
            ),
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
                  builder: (BuildContext context) => Bar(
                    lastIndex: 4,
                  ),
                ),
              );
            },
            child: Icon(
              Icons.close,
              color: Colors.black45,
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: BlocProvider<ScanNfcPageBloc>(
          create: (_) => ScanNfcPageBloc(),
          child: Center(
            child: BlocBuilder<ScanNfcPageBloc, BlocState>(
                builder: (context, state) {
              if (state is Waiting) {
                return dialogContent(context);
              }
              if (state is Success) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) => Bar(
                          lastIndex: 4,
                        ),
                      ));
                });
              }
              if (state is Error) {
                return ErrorHandling(
                  description: state.error,
                  routeClose: Bar(
                    lastIndex: ScanNFCPage.pageNumber,
                  ),
                );
              }
              return CircularProgressIndicator();
            }),
          )),
    );
  }
}
