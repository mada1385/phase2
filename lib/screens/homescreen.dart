import 'package:connectivity_wrapper/connectivity_wrapper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gulfgoal/config/colors.dart';
import 'package:gulfgoal/config/provider.dart';
import 'package:gulfgoal/locale/locales.dart';
import 'package:gulfgoal/screens/favouritesscreen.dart';
import 'package:gulfgoal/screens/gamescreen.dart';
import 'package:gulfgoal/screens/homenewsscrren.dart';
import 'package:gulfgoal/screens/newsscreen.dart';
import 'package:gulfgoal/screens/nointernetscreen.dart';
import 'package:gulfgoal/screens/profileoptions.dart';
import 'package:provider/provider.dart';

class Homescreen extends StatefulWidget {
  @override
  _HomescreenState createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  List widgetOptions = <Widget>[
    Homenewsscreen(),
    Gamescreen(),
    Newsscreen(),
    Favoutitesscreen(),
    Profileoptions()
  ];
  void _onItemTapped(int index) {
    setState(() {
      Provider.of<Userprovider>(context, listen: false)
          .sethomecreenindex(index);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    int _selectedIndex = Provider.of<Userprovider>(context).homescreenindex;

    return ConnectivityWidgetWrapper(
      offlineWidget: Nointernetscreen(),
      child: Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          selectedIconTheme: IconThemeData(color: accentcolor),
          selectedLabelStyle: TextStyle(
              color: accentcolor,
              fontFamily: Provider.of<Userprovider>(context, listen: false)
                  .font(context)),
          unselectedItemColor: textcolor,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              backgroundColor: Colors.white,
              icon: Icon(
                Icons.home,
              ),
              label: AppLocalizations.of(context).home.toString(),
            ),
            BottomNavigationBarItem(
              backgroundColor: Colors.white,
              icon: Icon(Icons.sports_soccer),
              label: AppLocalizations.of(context).games.toString(),
            ),
            BottomNavigationBarItem(
                backgroundColor: Colors.white,
                icon: Icon(FontAwesomeIcons.newspaper),
                label: AppLocalizations.of(context).news.toString()),
            BottomNavigationBarItem(
                backgroundColor: Colors.white,
                icon: Icon(Icons.star),
                label: AppLocalizations.of(context).favourites.toString()),
            BottomNavigationBarItem(
                backgroundColor: Colors.white,
                icon: Icon(Icons.person),
                label: AppLocalizations.of(context).profile.toString()),
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
