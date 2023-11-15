import 'package:flutter/material.dart';

import 'package:hangout_app/screens/auth.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HangOut',
      theme: ThemeData().copyWith(
        useMaterial3: true,
        colorScheme:
            ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 255, 255, 255)),
      ),
      home: const AuthScreen(),
    );
  }
}
