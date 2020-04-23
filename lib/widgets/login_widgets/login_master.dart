import 'package:final_project/app_bar.dart';
import 'package:final_project/blocs/app/app_bloc.dart';
import 'package:final_project/blocs/app/app_state.dart';
import 'package:final_project/blocs/bloc_event.dart';
import 'package:final_project/blocs/bloc_state.dart';
import 'package:final_project/blocs/login_page_bloc.dart';
import 'package:final_project/services/time_service.dart';
import 'package:final_project/widgets/login_widgets/logo_loading.dart';
import 'package:final_project/widgets/shared/data_loading_screen.dart';
import 'package:final_project/widgets/shared/media_query.dart';
import 'package:flutter/material.dart';
import 'package:final_project/widgets/login_widgets/google_login_button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginMaster extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: LoginMasterStf(),
    );
  }
}

class LoginMasterStf extends StatefulWidget {
  @override
  _LoginMasterStfState createState() => _LoginMasterStfState();
}

class _LoginMasterStfState extends State<LoginMasterStf> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppBloc, AppState>(
      builder: (context, mainState) {
        String currentState;
        if (mainState is Online) {
          currentState = mainState.stateVal;
        } else if (mainState is Offline) {
          currentState = mainState.stateVal;
        }
        return BlocBuilder<LoginPageBloc, BlocState>(
          builder: (context, state) {
            if (state is Waiting) {
              if (state.isThrowback) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  final snackBar = SnackBar(
                    content: Text('Invalid Account.'),
                  );
                  Scaffold.of(context).showSnackBar(snackBar);
                });
              }
              return Container(
                padding: EdgeInsets.symmetric(horizontal: 40),
                decoration: BoxDecoration(color: Colors.white),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      height: displayHeight(context) * 20,
                    ),
                    Image.asset(
                      'assets/mineager_logo.png',
                      height: displayHeight(context) * 30,
                    ),
                    GoogleLoginButton(),
                    SizedBox(
                      height: displayHeight(context) * 17,
                    ),
                    Image.asset(
                      'assets/powered_by.png',
                      height: displayHeight(context) * 5,
                    ),
                  ],
                ),
              );
            }
            if (state is Error) {
              return Container();
            }
            if (state is Success) {
              //MarkneedsBuild
              WidgetsBinding.instance.addPostFrameCallback((_) {
                if (state.result == null) {
                  // this mean it request the firsttime dump
                  Navigator.of(context)
                      .pushReplacementNamed(DataLoadingScreen.tag);
                } else if (state.result == TimeService().getDate()) {
                  Navigator.of(context).pushReplacementNamed(Bar.tag);
                } else {
                  // the update dump
                  // set this to not run when state is offline
                  if (currentState == 'online') {
                    Navigator.of(context)
                        .pushReplacementNamed(DataLoadingScreen.tag);
                  } else {
                    Navigator.of(context).pushReplacementNamed(Bar.tag);
                  }
                }
              });
              return Container();
            }
            if (state is InitCheck) {
              BlocProvider.of<LoginPageBloc>(context).add(LoginCheck());
            }
            return Scaffold(
              backgroundColor: Colors.white,
              body: LogoLoading(),
            );
          },
        );
      },
    );
  }
}
