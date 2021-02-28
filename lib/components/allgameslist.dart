import 'dart:async';
import 'package:flutter/material.dart';
import 'package:gulfgoal/components/fixturelist.dart';
import 'package:gulfgoal/config/colors.dart';
import 'package:gulfgoal/config/provider.dart';
import 'package:gulfgoal/locale/locales.dart';
import 'package:gulfgoal/models/match.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class Allgameslist extends StatefulWidget {
  @override
  _AllgameslistState createState() => _AllgameslistState();
}

class _AllgameslistState extends State<Allgameslist> {
  Timer _clockTimer;
  DateFormat formatter = DateFormat('yyyy-MM-dd');
  void isstrem() {
    setState(() {
      if (formatter.format(
              Provider.of<Userprovider>(context, listen: false).selectedDate) ==
          formatter.format(
              Provider.of<Userprovider>(context, listen: false).currentdate)) {
        Provider.of<Userprovider>(context, listen: false)
            .loadAllgamesdetailsDetails();
      }
    });
  }

  @override
  void initState() {
    // Provider.of<Userprovider>(context, listen: false)
    //     .loadAllgamesdetailsDetails();
    _clockTimer = Timer.periodic(Duration(seconds: 20), (_) => isstrem());
    super.initState();
  }

  void dispose() {
    _clockTimer.cancel();
    super.dispose();
    // _userController.close();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Provider.of<Userprovider>(context)
          .allgamesuserController
          .stream, //Here we will call our getData() method,
      builder: (context, snapshot) {
        //the future builder is very intersting to use when you work with api
        if (snapshot.hasData) {
          if (snapshot.data[0] != null) {
            List<dynamic> matchesList = snapshot.data;
            print("Api service: ${snapshot.data}"); // to debug
            List<SoccerMatch> matches = matchesList
                .map((dynamic item) => SoccerMatch.fromJson(item))
                .toList();
            return Fixturelist(
              allmatches: matches,
            );
          } else {
            return Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    AppLocalizations.of(context).nomatchestoday,
                    style: TextStyle(
                        fontFamily:
                            Provider.of<Userprovider>(context, listen: false)
                                .font(context),
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: accentcolor),
                  ),
                ],
              ),
            );
          }
        } else {
          return Expanded(
            child: Center(
                child: Theme(
              data: Theme.of(context).copyWith(accentColor: accentcolor),
              child: new CircularProgressIndicator(
                backgroundColor: Colors.black26,
              ),
            )),
          );
        }
      }, // here we will buil the app layout
    );
  }
}
