import 'package:flutter/material.dart';

class Constants {
  static const Color darkestBlue = Color(0xff212c32);
  static const Color darkBlue = Color(0xff2b3a42);
  static const Color lightBlue = Color(0xff31424d);
  static const primaryTextStyle = TextStyle(fontSize: 14, color: Colors.white);
  static const primaryTextStyleClickable = TextStyle(fontSize: 14, color: Colors.blue);
  static const primarySmallTextStyle = TextStyle(fontSize: 12, color: Colors.white);
  static const textFieldBorderRadius = BorderRadius.all(Radius.circular(30));
  static const String apiBaseUrl = 'http://animension.to';
  static const Map<String, String> searchTypes = {
    'All': '',
    'Subbed': '0',
    'Dubbed': '1',
    'Chinese': '3'
  };
  static const Map<String, String> searchStatuses = {
    'All': '',
    'Ongoing': '1',
    'Completed': '0'
  };
  static const Map<String, String> searchSorts = {
    'Popular (Week)': 'popular-week',
    'Popular (Year)': 'popular-year',
    'A-Z': 'az',
    'Z-A': 'za',
    'MAL Score': 'ranking',
  };

  static void scaffoldMessageToast(BuildContext context, Widget widget) {
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: widget)
    );
  }
}