import 'dart:async';
import 'package:final_project/auth.dart';
import 'package:final_project/blocs/bloc_event.dart';
import 'package:final_project/blocs/bloc_state.dart';
import 'package:final_project/local/services/db_service.dart';
import 'package:final_project/services/user_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPageBloc extends Bloc<BlocEvent, BlocState> {
  @override
  BlocState get initialState => InitCheck();

  @override
  Stream<BlocState> mapEventToState(BlocEvent event) async* {
    if (event is Login) {
      yield Loading();
      try {
        final FirebaseUser user = await signInWithGoogle();
        final result = await userService.login(user.email, 'admin');
        if (result == 401) {
          final googleAuth = await getCurrentUser();
          await signOutGoogle();
          await googleAuth.delete();

          yield Waiting(isThrowback: true);
        } else {
          final firstTime = await dbService.firstTimeCheck();
          yield Success(firstTime);
        }
      } catch (e) {
        yield Waiting(isThrowback: false);
      }
    } else if (event is LoginCheck) {
      yield Loading();
      try {
        final user = await dbService.getSavedUser();
        // {id: "idusernya", token: "tokennya"}
        await dbService.open();
        if (user['id'] == null) {
          //here mean he has not logged in or had logged out before
          yield Waiting(isThrowback: false);
        } else {
          // here mean he is already logged in
          final lastUpdated = await dbService.firstTimeCheck();
          await userService.setIdAndToken();
          yield Success(lastUpdated);
        }
      } catch (e) {
        yield Waiting(isThrowback: false);
      }
    }
  }
}
