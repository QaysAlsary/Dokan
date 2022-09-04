import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Text(
        'Settings Screen',
        style:TextStyle(
          fontSize: 32.0,
          fontWeight: FontWeight.bold,
        ) ,
      ),
    );
  }
}
