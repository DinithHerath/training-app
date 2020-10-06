import 'package:flutter/material.dart';
import 'package:training_app/theme.dart';
import 'package:training_app/views/home/home.dart';

void main() {
  runApp(DearDiaryApp());
}

class DearDiaryApp extends StatelessWidget {
  final _navigatorKey = GlobalKey<NavigatorState>();
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: _navigatorKey,
      theme: buildThemeData(),
      debugShowCheckedModeBanner: false,
      title: 'DearDiary',
      initialRoute: '/',
      routes: {
        "/": (context) => HomePage(),
      },
    );
  }
}

