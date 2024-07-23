import 'package:controller/main.dart';
import 'package:controller/services/sender.dart';
import 'package:flutter/material.dart';
import 'package:flutter_joystick/flutter_joystick.dart';
import 'package:provider/provider.dart';
class ControllerPage extends StatefulWidget {
  const ControllerPage({super.key});

  @override
  State<ControllerPage> createState() => _ControllerPageState();
}

class _ControllerPageState extends State<ControllerPage> {

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    final sender = Sender(appState.connection);
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Joystick(
            stick: CircleAvatar(
              radius: 20,
              backgroundColor: Theme.of(context).colorScheme.primary,
            ),
            base: Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondary,
                shape: BoxShape.circle,
              ),
            ),
            listener: (details) {
              sender.moveCursor(details.x, details.y);
            },
          ),
          const SizedBox(height: 50),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: Icon(
                  Icons.arrow_left_rounded, 
                  size: 50,
                  color: Theme.of(context).colorScheme.primary,
                ),
                onPressed: () => sender.click(ButtonType.left),
              ),
              const SizedBox(width: 50),
              IconButton(
                icon: Icon(
                  Icons.arrow_right_rounded, 
                  size: 50,
                  color: Theme.of(context).colorScheme.primary,
                ),
                onPressed: () => sender.click(ButtonType.right),
              ),
            ],
          ),
        ],
      )
    );
  }
}