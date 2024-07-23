import 'package:controller/pages/controller.dart';
import 'package:controller/pages/settings.dart';
import 'package:flutter/material.dart';

class StyledDrawer extends StatelessWidget {
  final Function(Widget) onPageSelected;
  const StyledDrawer({super.key, required this.onPageSelected});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.tertiary,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 70),
            child: Center(
              child: Icon(Icons.connected_tv_rounded, size: 100, color: Theme.of(context).colorScheme.primary),
            ),
          ),
          ListTile(
            leading: Icon(
              Icons.contactless_outlined, 
              color: Theme.of(context).colorScheme.primary
            ),
            title: Text(
              'У П Р А В Л Е Н И Е', 
              style: TextStyle(color: Theme.of(context).colorScheme.primary)),
            onTap: () {
              Navigator.pop(context);
              onPageSelected(const ControllerPage());
            },
          ),
          ListTile(
            leading: Icon(
              Icons.settings_outlined, 
              color: Theme.of(context).colorScheme.primary
            ),
            title: Text(
              'Н А С Т Р О Й К И', 
              style: TextStyle(color: Theme.of(context).colorScheme.primary)),
            onTap: () {
              Navigator.pop(context);
              onPageSelected(const SettingsPage());
            },
          ),
        ],
      ),
    );
  }
}