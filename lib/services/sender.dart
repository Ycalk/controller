import 'dart:convert';

import 'package:controller/services/connection.dart';
import 'package:http/http.dart' as http;

enum ButtonType { left, right }

class Sender {
  final Connection connection;
  Sender(this.connection);

  void moveCursor(double xOffset, double yOffset, {double speed = 20}) async {
    if (connection.status != ConnectionStatus.connected) return;
    final headers = {'Content-Type': 'application/json'};
    final body = jsonEncode({'xOffset': xOffset * speed, 'yOffset': yOffset * speed});
    try {
      await http
          .post(connection.uri!.replace(path: '${connection.uri!.path}/move_cursor'), headers: headers, body: body)
          .timeout(const Duration(seconds: 2));
    } catch (e) {
      connection.disconnect();
    }
  }

  void click(ButtonType type) async {
    if (connection.status != ConnectionStatus.connected) return;
    final headers = {'Content-Type': 'application/json'};
    final body = jsonEncode({'button': type.toString().split('.').last});
    try {
      await http.post(connection.uri!.replace(path: '${connection.uri!.path}/click'),
          headers: headers, body: body).timeout(const Duration(seconds: 2));
    } catch (e) {
      connection.disconnect();
    }
  }
}