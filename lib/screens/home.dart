import 'package:flutter/material.dart';
import 'package:hangout_app/widgets/main_drawer.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HangOut'),
      ),
      drawer: MainDrawer(),
      body: const Center(
        child: Text('Logged in!'),
      ),
    );
  }
}
