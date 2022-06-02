import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'screen/home/home.dart';

void main() {
  runApp(DevicePreview(
    enabled: true,
    builder: (_) => MaterialApp(
      useInheritedMediaQuery: true,
      builder: DevicePreview.appBuilder,
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      darkTheme: ThemeData(primaryColor: Colors.white),
      home: const HomeScreen(),
    ),
  ));
}
