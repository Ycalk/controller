import 'package:flutter/material.dart';
import 'package:controller/services/connection.dart';

class AppBarTitle extends StatelessWidget {
  final Connection connection;
  const AppBarTitle({super.key, required this.connection});

  @override
  Widget build(BuildContext context) {
    switch (connection.status) {
      case ConnectionStatus.disconnected:
        return Row(
          children: [
            Icon(Icons.warning, color: Theme.of(context).colorScheme.primary),
            const SizedBox(width: 15),
            Text(
              'О Т К Л Ю Ч Е Н О', 
              style: TextStyle(
                fontSize: 15,
                color: Theme.of(context).colorScheme.primary,
              )
            ),
          ],
        );
      case ConnectionStatus.connecting:
        return Row(
          children: [
            Transform.scale(
              scale: 0.5,
              child: CircularProgressIndicator(),
            ),
            const SizedBox(width: 15),
            Text(
              'П О Д К Л Ю Ч Е Н И Е', 
              style: TextStyle(
                fontSize: 15,
                color: Theme.of(context).colorScheme.primary,
                fontStyle: FontStyle.italic
              )
            ),
          ],
        );
      case ConnectionStatus.connected:
        return Row(
          children: [
            Icon(Icons.check, color: Theme.of(context).colorScheme.primary),
            const SizedBox(width: 15),
            Text(
              'П О Д К Л Ю Ч Е Н О', 
              style: TextStyle(
                fontSize: 15,
                color: Theme.of(context).colorScheme.primary,
              )
            ),
          ],
        );
      default:
        return Text(
          'О Ш И Б К А', 
          style: TextStyle(
            fontSize: 15,
            color: Theme.of(context).colorScheme.primary,
          )
        );
    }
  }
}