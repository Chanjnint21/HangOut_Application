import 'package:flutter/material.dart';
// import 'package:hangout_app/screens/card_details.dart';
import 'package:hangout_app/screens/draft.dart';
import 'package:hangout_app/screens/home.dart';
import 'package:hangout_app/widgets/main_drawer.dart';

class AppScreen extends StatefulWidget {
  const AppScreen({super.key});
  @override
  State<AppScreen> createState() => _AppScreenState();
}

class _AppScreenState extends State<AppScreen> {
  var _screenName = 'Home';

  Widget currentScreen = const SingleChildScrollView(
    child: Column(
      children: [
        HomeScreen(),
      ],
    ),
  );

  @override
  Widget build(BuildContext context) {
    // int _selectedPageIndex = 0;

    // void _selectPage(int index) {
    //   setState(() {
    //     _selectedPageIndex = index;
    //   });
    // }

    void _setScreen(String identifier) {
      Navigator.of(context).pop();
      setState(() {
        if (identifier == 'home') {
          _screenName = 'Home';
          currentScreen = const SingleChildScrollView(
            child: Column(
              children: [
                HomeScreen(),
              ],
            ),
          );
        } else if (identifier == 'draft') {
          _screenName = 'Draft';
          currentScreen = const SingleChildScrollView(
            child: Column(
              children: [
                DraftScreen(),
              ],
            ),
          );
        }
      });
    }

    // Widget currentScreen = SingleChildScrollView(
    //   child: Column(
    //     children: [
    //       currentScreen,
    //     ],
    //   ),
    // );

    return Scaffold(
      appBar: AppBar(
        title: Text(_screenName),
      ),
      drawer: MainDrawer(
        onSelectScreen: _setScreen,
      ),
      body: currentScreen,
    );
  }
}
