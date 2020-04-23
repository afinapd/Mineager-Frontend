import 'package:final_project/app_bar.dart';
import 'package:final_project/blocs/bloc_event.dart';
import 'package:final_project/blocs/bloc_state.dart';
import 'package:final_project/blocs/dump_bloc.dart';
import 'package:final_project/pages/login_page.dart';
import 'package:final_project/pages/onboard_screen.dart';
import 'package:final_project/widgets/shared/error_handling.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class DataLoadingScreen extends StatelessWidget {
  static const tag = '/data-loading-screen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider<DumpBloc>(
        create: (_) => DumpBloc(),
        child: BlocBuilder<DumpBloc, BlocState>(
          builder: (context, state) {
            if (state is Waiting) {
              BlocProvider.of<DumpBloc>(context).add(RequestDump());
            }
            if (state is Success) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                if (state.result != 'firstTime') {
                  Navigator.of(context).pushReplacementNamed(Bar.tag);
                } else {
                  //change this to onboarding screen later
                  Navigator.of(context).pushReplacementNamed(OnboardScreen.tag);
                }
              });
            }
            if (state is Error) {
              return ErrorHandling(
                description: state.error,
                routeClose: LoginPage(),
              );
            }
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 200,
                ),
                SpinKitHourGlass(color: Colors.grey, size: 50),
                SizedBox(
                  height: 50,
                ),
                Text(
                  'Your data is loading...',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                Text(
                  "Don't turn off your wifi or device during this process",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
