import 'package:final_project/blocs/bloc_event.dart';
import 'package:final_project/blocs/bloc_state.dart';
import 'package:final_project/local/services/user_service_local.dart';
import 'package:final_project/services/user_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ListPageBloc extends Bloc<BlocEvent, BlocState> {
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
          result = await UserServiceLocal().getUserById(event.id, event.type, event.page);
        }
        if (result == 401) {
          yield Error(401);
        } else {
          if (event.type == 'qr' || event.type == 'nfc') {
            if (result == 404) {
              yield Success([]);
            } else {
              yield Success([result]);
            }
          } else {
            yield Success(result);
          }
        }
      } catch (e) {
        yield Error(e);
      }
    }
  }
}
