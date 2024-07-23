import 'dart:async';

import 'package:http/http.dart' as http;

enum ConnectionStatus { connected, disconnected, connecting }


class Connection {
  static const int _checkInterval = 300;
  ConnectionStatus get status => _status;
  Uri? get uri => _ip != null ? Uri.parse("http://$_ip") : null;
  Stream<ConnectionStatus> get stream => _controller.stream;

  Connection() {
    Timer.periodic(const Duration(milliseconds: _checkInterval), (timer) async {
      try{
        await _ping().timeout(const Duration(seconds: 2));
      } catch (e) {
        _ip = null;
        _updateStatus(ConnectionStatus.disconnected);
      }
    });
  }
    

  ConnectionStatus _status = ConnectionStatus.disconnected;
  String? _ip;
  final StreamController<ConnectionStatus> _controller = StreamController<ConnectionStatus>.broadcast();

  Future<void> connect(String ip) async {
    _updateStatus(ConnectionStatus.connecting);
    _ip = ip;
  }

  Future<void> disconnect() async => _ip = null;

  Future<void> _ping() async {
    if (_ip != null) {
      try {
        final response = await http.get(Uri.parse("http://$_ip/ping"));
        if (response.statusCode == 200) {
          _updateStatus(ConnectionStatus.connected);
        } else {
          _updateStatus(ConnectionStatus.disconnected);
        }
      } catch (e) {
        _updateStatus(ConnectionStatus.disconnected);
      }
    } else {
      _updateStatus(ConnectionStatus.disconnected);
    }
  }

  void _updateStatus(ConnectionStatus newStatus) {
    _status = newStatus;
    _controller.add(_status);
  }
}