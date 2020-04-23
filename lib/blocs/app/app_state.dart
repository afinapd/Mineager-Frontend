abstract class AppState {}

class Static extends AppState {}

class Online extends AppState {
  final stateVal = 'online';
}

class Offline extends AppState {
  final stateVal = 'offline';
}
