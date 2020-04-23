import 'package:final_project/blocs/bloc_event.dart';
import 'package:final_project/blocs/bloc_state.dart';
import 'package:final_project/local/services/attendance_service.dart';
import 'package:final_project/local/services/user_service_local.dart';
import 'package:final_project/services/time_service.dart';
import 'package:final_project/services/user_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ScanNfcPageBloc extends Bloc<BlocEvent, BlocState> {
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
          if (result == 404) {
            yield Error('Data Not Found !');
          } else {
            yield Success(result);
          }
        }
      } catch (e) {
        yield Error("Sorry...");
      }
    } else if (event is SubmitAttendance) {
      yield Loading();
      try {
        var lastAbs;
        if (event.state == 'online') {
          lastAbs = await userService.fetchNewestPresenceById(event.userId);
        } else {
          lastAbs =
              await AttendanceService().getNewestAttendanceById(event.userId);
        }

        if (lastAbs == 401) {
          yield Error(401);
        } else {
          if (lastAbs != 404) {
            if (lastAbs['date'] == TimeService().getDate().toString()) {
              yield Error('This user has checked in for today');
              return;
            }
          }
          var result;
          if (event.state == 'online') {
            result = await userService.postAttendance(
                event.userId, event.date, event.time);
          }
          result = await AttendanceService().postAttendanceIn(
              event.userId, event.date, event.time, event.state);
          yield Success(result);
        }
      } catch (e) {
        if (e.response.statusCode == 404) {
          yield Error(e);
        } else {
          yield Error('Sorry..');
        }
      }
    } else if (event is CheckOut) {
      yield Loading();
      try {
        var result;
        if (event.state == 'online') {
          result =
              await userService.postAttendanceOut(event.userId, event.time);
        }
        result =
            await AttendanceService().postAttendanceOut(event.userId, event.time, event.state);

        if (result == 404) {
          yield Error(
              'This user either havent checked in or has checked out before.');
        } else {
          yield Success(result);
        }
      } catch (e) {
        if (e.response.statusCode == 404) {
          yield Error(e);
        } else {
          yield Error('Sorry..');
        }
      }
    }
  }
}
