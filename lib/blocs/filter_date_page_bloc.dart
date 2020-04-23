import 'package:final_project/blocs/bloc_event.dart';
import 'package:final_project/blocs/bloc_state.dart';
import 'package:final_project/local/services/attendance_service.dart';
import 'package:final_project/services/user_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FilterDatePageBloc extends Bloc<BlocEvent, BlocState> {
  @override
  BlocState get initialState => Waiting(isThrowback: false);

  @override
  Stream<BlocState> mapEventToState(BlocEvent event) async* {
    if (event is SearchPresenceByDate) {
      yield Loading();
      try {
        var result;
        if (event.state == 'online') {
          result =
              await userService.fetchPresenceByDate(event.date, event.page);
        } else {
          result = await AttendanceService()
              .getAttendanceByDate(event.date, event.page);
        }
        if (result.toString() == '[]') {
          yield Error('Oops no data here.');
        } else if (result == 401) {
          yield Error(401);
        } else {
          yield Success(result);
        }
      } catch (e) {
        if (e.toString() ==
            "Exception: RangeError (index): Invalid value: Valid value range is empty: 0") {
          yield Error("Oops no data here.");
        } else {
          yield Error("Sorry...");
        }
      }
    }
  }
}
