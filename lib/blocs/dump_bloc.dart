import 'package:final_project/auth.dart';
import 'package:final_project/blocs/bloc_event.dart';
import 'package:final_project/blocs/bloc_state.dart';
import 'package:final_project/local/services/db_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DumpBloc extends Bloc<BlocEvent, BlocState> {
  @override
  BlocState get initialState => Waiting(isThrowback: false);

  @override
  Stream<BlocState> mapEventToState(BlocEvent event) async* {
    if (event is RequestDump) {
      yield Loading();
      try {
        final result = await dbService.firstTimeCheck();
        if (result == null) {
          // != IS TEMPORARY IT SHOULD BE ==
          final firstTimeDump = await dbService.firstTimeDump();

          yield Success(firstTimeDump);
        } else {
          final dumpDelta = await dbService.dumpDelta();
          yield Success(dumpDelta);
        }
      } catch (e) {
        if (e.message == 401) {
          yield Error('Invalid session. please relogin.');
          await signOutGoogle();
          await dbService.deleteCurrentUser();
          return;
        }
        yield Error('why did you do that :(');
      }
    } else if (event is SelfDestruct) {
      yield Loading();
      try {
        await dbService.cleanDatabase();
        yield Error('error');
      } on Exception {
        yield Error('e');
      }
    }
  }
}
