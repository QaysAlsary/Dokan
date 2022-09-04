import 'package:flutter/material.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      'Search Screen',
      style:TextStyle(
        fontSize: 32.0,
        fontWeight: FontWeight.bold,
      ) ,
    );
  }
}
