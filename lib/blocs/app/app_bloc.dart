import 'package:final_project/blocs/app/app_event.dart';
import 'package:final_project/blocs/app/app_state.dart';
import 'package:final_project/local/services/db_service.dart';
import 'package:final_project/services/dump_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  @override
  AppState get initialState => Static();

  @override
  Stream<AppState> mapEventToState(AppEvent event) async* {
    if (event is GoOnline) {
      yield Online();
      try {
        List<Map<String, dynamic>> datas = await dbService.prepSyncData();
        final result = await DumpService().synch(datas);
        await dbService.syncUpdate(result);
      } catch (e) {
        return;
      }
    } else if (event is GoOffline) {
      yield Offline();
    } else {
      yield Static();
    }
  }
}
