import 'package:controller/pages/main.dart';
import 'package:controller/services/connection.dart';
import 'package:controller/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => AppState(Connection()),
      child: const App(),
    ),
  );
}

class AppState extends ChangeNotifier {
  final Connection _connection;
  Connection get connection => _connection; 

  AppState(Connection connection) : _connection = connection {
    _connection.stream.listen((event) {
      notifyListeners();
    });
  }
}

class App extends StatelessWidget {
  const App({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Controller',
      theme: lightMode,
      home: const MainPage(),
    );
  }
}