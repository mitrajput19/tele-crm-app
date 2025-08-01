import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:socket_io_client/socket_io_client.dart';

import '../../app/app.dart';

class SocketServices {
  SocketServices._privateConstructor();

  static SocketServices? _instance;
  late Socket _socket;
  bool isConnected = false;

  factory SocketServices() {
    if (_instance == null) _instance = SocketServices._privateConstructor();
    return _instance!;
  }

  Socket get socket => _socket;

  Future<void> connect() async {
    if (!isConnected) {
      try {
        _socket = await IO
            .io(
              AppUrls.baseUrlWebSocket,
              OptionBuilder().setTransports(['websocket']).enableForceNewConnection().disableAutoConnect().build(),
            )
            .connect();

        isConnected = true;
        _socket.on('online', (data) => LogHelper.log('SocketServices : Online $data'));
        LogHelper.log('SocketServices : isConnected $isConnected');
      } catch (e) {
        LogHelper.log(tag: 'SocketServices : Error', e);
      }
    }
  }

  Future<void> disconnect() async {
    if (isConnected) {
      await _socket.close();
      isConnected = false;
      LogHelper.log('SocketServices : isConnected $isConnected');
    }
  }

  static void dispose() {
    _instance?.disconnect();
    _instance = null;
  }
}
