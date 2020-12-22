import 'package:connectivity_wrapper/connectivity_wrapper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gulfgoal/config/colors.dart';
import 'package:gulfgoal/screens/favouritesscreen.dart';
import 'package:gulfgoal/screens/gamescreen.dart';
import 'package:gulfgoal/screens/homenewsscrren.dart';
import 'package:gulfgoal/screens/newsscreen.dart';
import 'package:gulfgoal/screens/nointernetscreen.dart';
import 'package:gulfgoal/screens/profileoptions.dart';

class Homescreen extends StatefulWidget {
  @override
  _HomescreenState createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  int _selectedIndex = 0;
  List widgetOptions = <Widget>[
    Homenewsscreen(),
    Gamescreen(),
    Newsscreen(),
    Favoutitesscreen(),
    Profileoptions()
  ];
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ConnectivityWidgetWrapper(
      offlineWidget: Nointernetscreen(),
      child: Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.white,
          selectedIconTheme: IconThemeData(color: accentcolor),
          selectedLabelStyle:
              TextStyle(color: accentcolor, fontFamily: 'cairo'),
          unselectedItemColor: textcolor,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              backgroundColor: Colors.white,
              icon: Icon(
                Icons.home,
              ),
              title: Text('Home'),
            ),
            BottomNavigationBarItem(
              backgroundColor: Colors.white,
              icon: Icon(Icons.sports_soccer),
              title: Text('Games'),
            ),
            BottomNavigationBarItem(
              backgroundColor: Colors.white,
              icon: Icon(FontAwesomeIcons.newspaper),
              title: Text('News'),
            ),
            BottomNavigationBarItem(
              backgroundColor: Colors.white,
              icon: Icon(Icons.star),
              title: Text('Favourites'),
            ),
            BottomNavigationBarItem(
              backgroundColor: Colors.white,
              icon: Icon(Icons.person),
              title: Text('Profie'),
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: accentcolor,
          onTap: _onItemTapped,
        ),
        body: widgetOptions[_selectedIndex],
      ),
    );
  }
}
