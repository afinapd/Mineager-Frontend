import 'package:final_project/blocs/bloc_event.dart';
import 'package:final_project/blocs/login_page_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';


class GoogleLoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 25.0),
        width: 200,
        height: 100,
        child: SignInButton(
          Buttons.Google,
          onPressed: () {
            BlocProvider.of<LoginPageBloc>(context).add(Login());
          },
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          padding: EdgeInsets.only(left: 15),
        ),
      ),
    );
  }
}
