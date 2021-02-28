import 'package:connectivity_wrapper/connectivity_wrapper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:gulfgoal/screens/splash_page.dart';
import 'package:provider/provider.dart';
import 'config/provider.dart';
import 'locale/locales.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Firebase.initializeApp(),
        builder: (context, snapshot) {
          return ConnectivityAppWrapper(
            app: ChangeNotifierProvider(
              create: (context) => Userprovider(),
              child: MaterialApp(
                localizationsDelegates: [
                  AppLocalizationsDelegate(),
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                ],
                supportedLocales: [
                  Locale('en', ""),
                  Locale("ar", "MA"),
                ],
                title: 'Gulf Goal',
                theme: ThemeData(
                  visualDensity: VisualDensity.adaptivePlatformDensity,
                ),
                home: SplashScreen(),
              ),
            ),
          );
        });
  }
}
