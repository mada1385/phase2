import 'package:connectivity_wrapper/connectivity_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:gulfgoal/components/leaguefixturelist.dart';
import 'package:gulfgoal/components/texts.dart';
import 'package:gulfgoal/config/colors.dart';
import 'package:gulfgoal/config/mediaqueryconfig.dart';
import 'package:gulfgoal/config/provider.dart';
import 'package:gulfgoal/locale/locales.dart';
import 'package:gulfgoal/screens/nointernetscreen.dart';
import 'package:gulfgoal/screens/standingsscreen.dart';
import 'package:provider/provider.dart';

class Leaguesfixturescreen extends StatefulWidget {
  final String leaugeidtab;
  final String selecteddate;

  const Leaguesfixturescreen({Key key, this.leaugeidtab, this.selecteddate})
      : super(key: key);
  @override
  _LeaguesfixturescreenState createState() => _LeaguesfixturescreenState();
}

class _LeaguesfixturescreenState extends State<Leaguesfixturescreen> {
  int leaguetab = 0;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> leaugedetails = [
      Leaguefixturelist(),
      Standingscreen(),
    ];
    return Expanded(
      child: ConnectivityWidgetWrapper(
        offlineWidget: Nointernetscreen(),
        child: Container(
          child: Column(
            children: [
              Container(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: SizeConfig.blockSizeHorizontal * 1),
                  child: Column(
                    children: <Widget>[
                      Container(
                        color: Color(0xffFCFCFC),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: FlatButton(
                                  onPressed: () {
                                    setState(() {
                                      leaguetab = 0;
                                      // Provider.of<Userprovider>(context,
                                      //         listen: false)
                                      //     .loadAllgamesdetailsDetails();
                                    });
                                  },
                                  child: Column(
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                            border: Border(
                                                bottom: BorderSide(
                                          color: leaguetab == 0
                                              ? accentcolor
                                              : Colors.transparent,
                                          width: 2,
                                        ))),
                                        child: Normaltext(
                                          string: AppLocalizations.of(context)
                                              .fixtures,
                                          fontsize: 16,
                                          color: leaguetab == 0
                                              ? accentcolor
                                              : Colors.grey,
                                        ),
                                      ),
                                    ],
                                  )),
                            ),
                            SizedBox(
                              height: SizeConfig.blockSizeVertical * 4,
                              child: Container(
                                width: 1,
                                color: Colors.grey,
                              ),
                            ),
                            Expanded(
                              child: FlatButton(
                                  onPressed: () {
                                    setState(() {
                                      leaguetab = 1;
                                    });
                                  },
                                  child: Column(
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                            border: Border(
                                                bottom: BorderSide(
                                          color: leaguetab == 1
                                              ? accentcolor
                                              : Colors.transparent,
                                          width: 2,
                                        ))),
                                        child: Normaltext(
                                          string: AppLocalizations.of(context)
                                              .table,
                                          fontsize: 16,
                                          color: leaguetab == 1
                                              ? accentcolor
                                              : Colors.grey,
                                        ),
                                      ),
                                    ],
                                  )),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                // Standingscreen(),

                // TeamList(idLeague),
              ),
              leaugedetails[leaguetab],
            ],
          ),
        ),
      ),
    );
  }
}
