import 'package:final_project/app_bar.dart';
import 'package:final_project/blocs/app/app_bloc.dart';
import 'package:final_project/blocs/app/app_event.dart';
import 'package:final_project/blocs/app/app_state.dart';
import 'package:final_project/constant/socket_io.dart';
import 'package:final_project/pages/list_page.dart';
import 'package:final_project/pages/login_page.dart';
import 'package:final_project/pages/onboard_screen.dart';
import 'package:final_project/pages/profile_page.dart';
import 'package:final_project/widgets/shared/data_loading_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(MyApp());
}

final routes = <String, WidgetBuilder>{
  '/': (_) => LoginPage(),
  DataLoadingScreen.tag: (_) => DataLoadingScreen(),
  Bar.tag: (context) => Bar(),
  LoginPage.tag: (context) => LoginPage(),
  ProfilePage.tag: (context) => ProfilePage(),
  ListPage.tag: (context) => ListPage(),
  OnboardScreen.tag: (_) => OnboardScreen(),
};

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // SystemChrome.setEnabledSystemUIOverlays([]);

    return BlocProvider<AppBloc>(
      create: (_) => AppBloc(),
      child: BlocBuilder<AppBloc, AppState>(
        builder: (context, mainState) {
          ioMain.onConnect(() {
            ioMain.socket.clearListeners();
            BlocProvider.of<AppBloc>(context).add(GoOnline());
          });
          ioMain.onDisconnect(() {
            ioMain.socket.clearListeners();
            BlocProvider.of<AppBloc>(context).add(GoOffline());
          });
          ioMain.onConnectError(() {
            ioMain.socket.clearListeners();
            BlocProvider.of<AppBloc>(context).add(GoOffline());
          });
          ioMain.onConnectTimeOut(() {
            ioMain.socket.clearListeners();
            BlocProvider.of<AppBloc>(context).add(GoOffline());
          });
          return MaterialApp(
            title: 'Mineager',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primarySwatch: Colors.red,
              fontFamily: 'Nunito',
            ),
            initialRoute: '/',
            routes: routes,
          );
        },
      ),
    );
  }
}
