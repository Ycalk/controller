import 'package:controller/components/app_bar_title.dart';
import 'package:controller/components/drawer.dart';
import 'package:controller/main.dart';
import 'package:controller/pages/controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';



class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}



class _MainPageState extends State<MainPage> {

  Widget currentPage = const ControllerPage();

  void _onSelectPage(Widget page) {
    setState(() {
      currentPage = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    return Scaffold(
        drawer: StyledDrawer(onPageSelected: _onSelectPage,),
        appBar: AppBar(
          leading: Builder(
            builder: (context) => IconButton(
              icon: Icon(Icons.menu_rounded, 
              color: Theme.of(context).colorScheme.primary),
              onPressed: () => Scaffold.of(context).openDrawer(),
            ),
          ),
          backgroundColor: Theme.of(context).colorScheme.tertiary,
          title: AnimatedSwitcher(
            duration: const Duration(milliseconds: 200),
            child:  AppBarTitle(key: ValueKey(appState.connection.status), connection: appState.connection),
          ),
        ),
        body: AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          child: currentPage
        ),
      );
  }
}