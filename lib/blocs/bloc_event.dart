abstract class BlocEvent {}

class SearchUserById extends BlocEvent {
  final String id;
  final String type;
  final int page;
  final String state;

  SearchUserById(this.id, this.type, this.page, this.state);
}

class SearchPresenceByUserId extends BlocEvent {
  final String userId;
  final int page;
  final String state;
  SearchPresenceByUserId(this.userId, this.page, this.state);
}

class SearchPresenceByDate extends BlocEvent {
  final String date;
  final int page;
  final String state;

  SearchPresenceByDate(this.date, this.page, this.state);
}

class SearchNewestPresenceById extends BlocEvent {
  final String id;
  SearchNewestPresenceById(this.id);
}

class SubmitAttendance extends BlocEvent {
  final String userId;
  final String date;
  final String time;
  final String state;

  SubmitAttendance(this.userId, this.date, this.time, this.state);
}

class CheckOut extends BlocEvent {
  final String userId;
  final String time;
  final String state;

  CheckOut(this.userId, this.time, this.state);
}

class Login extends BlocEvent {}

class LoginCheck extends BlocEvent {}

class RequestDump extends BlocEvent {}

class SelfDestruct extends BlocEvent {}

class SearchPresenceByDateAndUserId extends BlocEvent {
  final String date;
  final String userId;
  final int page;
  final String state;

  SearchPresenceByDateAndUserId(this.date, this.userId, this.page, this.state);
}
