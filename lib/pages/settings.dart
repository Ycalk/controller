
import 'package:network_info_plus/network_info_plus.dart';
import 'package:controller/components/text_field.dart';
import 'package:controller/main.dart';
import 'package:controller/services/connection.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:switcher_button/switcher_button.dart';


class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final TextEditingController _hostController = TextEditingController();
  final TextEditingController _portController = TextEditingController();

  String mergeIp(String wifiIp) {
    final ip = wifiIp.split('.');
    ip[ip.length - 1] = _hostController.text;
    return "${ip.join('.')}:${_portController.text}";
  }

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              Expanded(
                child: StyledTextField(
                  hintText: "Host",
                  controller: _hostController,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                flex: 2,
                child: StyledTextField(
                  hintText: "Port",
                  controller: _portController,
                ),
              ),
            ],
          ),
          const SizedBox(height: 50),
          Center(
            child: SwitcherButton(
              size: 100,
              offColor: Theme.of(context).colorScheme.secondary,
              onColor: Theme.of(context).colorScheme.primary,
              value: appState.connection.status == ConnectionStatus.connected,
              onChange: (value) async {
                final info = NetworkInfo();
                String? ip = await info.getWifiGatewayIP();
                if (ip == null){
                  await appState.connection.disconnect();
                  return;
                }
                if(value) {
                  await appState.connection.connect(mergeIp(ip));
                } else {
                  await appState.connection.disconnect();
                }
              },
            )
          )
        ],
      )
    );
  }
}