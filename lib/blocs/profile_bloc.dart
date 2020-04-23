import 'package:final_project/blocs/bloc_event.dart';
import 'package:final_project/blocs/bloc_state.dart';
import 'package:final_project/local/services/attendance_service.dart';
import 'package:final_project/local/services/user_service_local.dart';
import 'package:final_project/services/user_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileBloc extends Bloc<BlocEvent, BlocState> {
  @override
  BlocState get initialState => Waiting(isThrowback: false);

  @override
  Stream<BlocState> mapEventToState(BlocEvent event) async* {
    if (event is SearchUserById) {
      yield Loading();
      try {
        var result;
        if (event.state == 'online') {
          result =
              await userService.fetchById(event.id, event.type, event.page);
        } else {
          result = await UserServiceLocal()
              .getUserById(event.id, event.type, event.page);
        }

        if (result == 401) {
          yield Error(401);
        } else {
          yield Success(result);
        }
      } catch (e) {
        yield Error(e);
      }
    } else if (event is SearchPresenceByUserId) {
      yield Loading();
      try {
        final result =
            await userService.fetchPresenceByUserId(event.userId, event.page);

        if (result == 401) {
          yield Error(401);
        } else if (result == 404 || result == 500) {
          yield Error('E');
        } else {
          yield Success(result);
        }
      } catch (e) {
        yield Error(e);
      }
    } else if (event is SearchPresenceByDateAndUserId) {
      yield Loading();
      try {
        var result;
        if (event.state == 'online') {
          result = await userService.fetchPresenceByDateAndUserId(
              event.date, event.userId, event.page);
        } else {
          result = await AttendanceService().getAttendanceByUserIdAndDate(
              event.userId, event.date, event.page);
        }

        if (result == 401) {
          yield Error(401);
        } else {
          yield Success(result);
        }
      } catch (e) {
        yield Error(e);
      }
    }
  }
}
