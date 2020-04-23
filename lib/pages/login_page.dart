import 'package:final_project/blocs/login_page_bloc.dart';
import 'package:final_project/widgets/login_widgets/login_master.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatefulWidget {
  static String tag = 'login-page';
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<LoginPageBloc>(
      create: (_) => LoginPageBloc(),
      child: LoginMaster(),
    );
  }
}
