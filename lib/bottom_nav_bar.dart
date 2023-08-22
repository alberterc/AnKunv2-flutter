import 'package:flutter/material.dart';
import 'package:ankunv2_flutter/constants.dart';
import 'package:ankunv2_flutter/screens/home/home_screen.dart';
import 'package:ankunv2_flutter/screens/season/season_screen.dart';
import 'package:ankunv2_flutter/screens/search/search_screen.dart';
import 'package:ankunv2_flutter/screens/favorites/favorites_screen.dart';
import 'package:ankunv2_flutter/screens/profile/profile_screen.dart';

class BottomNavBarApp extends StatefulWidget {
  const BottomNavBarApp({super.key});

  @override
  State<BottomNavBarApp> createState() => BottomNavBarState();
}

class BottomNavBarState extends State<BottomNavBarApp> {
  int selectedItemIndex = 0;
  List<Widget> itemIndexBody = const <Widget>[
    HomeScreen(),
    SeasonScreen(),
    SearchScreen(),
    FavoritesScreen(),
    ProfileScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(child: itemIndexBody.elementAt(selectedItemIndex)),
        bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.shifting,
            backgroundColor: Constants.darkBlue,
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                  icon: const Icon(Icons.home_outlined),
                  label: 'Home',
                  backgroundColor: Constants.darkBlue,
                  activeIcon: Container(
                      padding: const EdgeInsets.fromLTRB(20, 3, 20, 3),
                      decoration: BoxDecoration(
                          borderRadius:
                          const BorderRadius.all(Radius.circular(20)),
                          color: Colors.grey.withOpacity(0.25)),
                      child: const Icon(Icons.home_outlined))),
              BottomNavigationBarItem(
                  icon: const Icon(Icons.info_outlined),
                  label: 'Season',
                  backgroundColor: Constants.darkBlue,
                  activeIcon: Container(
                      padding: const EdgeInsets.fromLTRB(20, 3, 20, 3),
                      decoration: BoxDecoration(
                          borderRadius:
                          const BorderRadius.all(Radius.circular(20)),
                          color: Colors.grey.withOpacity(0.25)),
                      child: const Icon(Icons.info_outlined))),
              BottomNavigationBarItem(
                  icon: const Icon(Icons.search_outlined),
                  label: 'Search',
                  backgroundColor: Constants.darkBlue,
                  activeIcon: Container(
                      padding: const EdgeInsets.fromLTRB(20, 3, 20, 3),
                      decoration: BoxDecoration(
                          borderRadius:
                          const BorderRadius.all(Radius.circular(20)),
                          color: Colors.grey.withOpacity(0.25)),
                      child: const Icon(Icons.search_outlined))),
              BottomNavigationBarItem(
                  icon: const Icon(Icons.favorite_border_outlined),
                  label: 'Favorites',
                  backgroundColor: Constants.darkBlue,
                  activeIcon: Container(
                      padding: const EdgeInsets.fromLTRB(20, 3, 20, 3),
                      decoration: BoxDecoration(
                          borderRadius:
                          const BorderRadius.all(Radius.circular(20)),
                          color: Colors.grey.withOpacity(0.25)),
                      child: const Icon(Icons.favorite_border_outlined))),
              BottomNavigationBarItem(
                  icon: const Icon(Icons.person_outline),
                  label: 'Profile',
                  backgroundColor: Constants.darkBlue,
                  activeIcon: Container(
                      padding: const EdgeInsets.fromLTRB(20, 3, 20, 3),
                      decoration: BoxDecoration(
                          borderRadius:
                          const BorderRadius.all(Radius.circular(20)),
                          color: Colors.grey.withOpacity(0.25)),
                      child: const Icon(Icons.person_outline)))
            ],
            currentIndex: selectedItemIndex,
            selectedItemColor: Colors.blue,
            unselectedItemColor: Colors.white60,
            onTap: onItemIndexTapped));
  }

  void onItemIndexTapped(int index) {
    setState(() {
      selectedItemIndex = index;
    });
  }
}