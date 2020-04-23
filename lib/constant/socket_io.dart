import 'package:final_project/constant/constants.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class IOMain {
  IO.Socket socket = IO.io(API, <String, dynamic>{
    'transports': ['websocket'],
  });

  onConnect(Function callback) {
    socket.on('connect', (_) {
      print('connected to socket server');
      callback();
    });
  }

  onDisconnect(Function callback) {
    socket.on('disconnect', (_) {
      print('disconnected to socket server');
      callback();
    });
  }

  onConnectTimeOut(Function callback) {
    socket.on('connect_timeout', (_) {
      print('connect timeout to socket server');
      callback();
    });
  }

  onConnectError(Function callback) {
    socket.on('connect_error', (_) {
      print('connect error to socket server');
      callback();
    });
  }
}

final ioMain = IOMain();
