import 'package:final_project/blocs/app/app_bloc.dart';
import 'package:final_project/blocs/app/app_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class OfflineIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppBloc, AppState>(
      builder: (context, mainState) {
        String currentState;
        if (mainState is Offline) {
          currentState = mainState.stateVal;
        } else if (mainState is Online) {
          currentState = mainState.stateVal;       
        }

        return Container(
          width: 50,
          child: Icon(
            FontAwesomeIcons.squareFull,
            size: 20,
            color: currentState == 'online'
                ? Color.fromRGBO(173, 255, 47, 8)
                : Colors.red,
          ),
        );
      },
    );
  }
}
