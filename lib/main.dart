import 'package:flutter/material.dart';
import 'package:flutter_bloc_boilerplate/screen/home/home.dart';

void main() {
  runApp(MaterialApp(
    title: 'Flutter Demo',
    theme: ThemeData(primarySwatch: Colors.blue),
    darkTheme: ThemeData(primaryColor: Colors.white),
    home: const HomeScreen(),
  ));
}
