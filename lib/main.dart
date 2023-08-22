import 'package:flutter/material.dart';
import 'package:ankunv2_flutter/constants.dart';
import 'package:ankunv2_flutter/bottom_nav_bar.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Clone App',
        home: const BottomNavBarApp(),
        theme: ThemeData(
            useMaterial3: true,
            brightness: Brightness.dark,
            scaffoldBackgroundColor: Constants.darkestBlue,
            primaryColor: Constants.darkestBlue,
        ),
    );
  }
}