import 'package:connectivity_wrapper/connectivity_wrapper.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:gulfgoal/components/matchtile.dart';
import 'package:gulfgoal/components/teamcard.dart';
import 'package:gulfgoal/components/texts.dart';
import 'package:gulfgoal/config/colors.dart';
import 'package:gulfgoal/config/mediaqueryconfig.dart';
import 'package:gulfgoal/models/match.dart';
import 'package:gulfgoal/screens/lineupscreen.dart';
import 'package:gulfgoal/screens/matchfactsscreen.dart';
import 'package:gulfgoal/screens/statsscreen.dart';
import 'package:gulfgoal/screens/matchchatsceen.dart';

import 'nointernetscreen.dart';

class MatchDetailsScreen extends StatefulWidget {
  final SoccerMatch match;

  const MatchDetailsScreen({Key key, this.match}) : super(key: key);
  @override
  _MatchDetailsScreenState createState() => _MatchDetailsScreenState();
}

class _MatchDetailsScreenState extends State<MatchDetailsScreen> {
  int tapindex = 0;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    List<Widget> detailscreen = [
      Statsscreen(
        match: widget.match,
      ),
      Lineupscreen(
        match: widget.match,
      ),
      Matchfactsscreen(
        match: widget.match,
      ),
      Matchchatscreen()
    ];
    return ConnectivityWidgetWrapper(
      offlineWidget: Nointernetscreen(),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          // drawer: IconButton(
          //   icon: Icon(Icons.sanitizer, size: 50),
          //   onPressed: () {
          //     Navigator.pop(context);
          //   },
          // ),
          body: Theme(
            data: ThemeData(accentColor: accentcolor),
            child: ListView(
              children: [
                Container(
                  decoration: BoxDecoration(
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                            color: Colors.black26,
                            blurRadius: 15.0,
                            offset: Offset(0.0, 1.0))
                      ],
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10))),
                  height: 177,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        height: 20,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            IconButton(
                              icon: Icon(
                                Icons.arrow_back,
                              ),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                          ],
                        ),
                      ),
                      Normaltext(
                        string: widget.match.fixture.status.league,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey,
                        fontsize: 12,
                      ),
                      Container(
                        height: 70,
                        child: Row(
                          // mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Teamcard(
                                logourl: widget.match.home.logoUrl,
                                teamname: widget.match.home.name,
                              ),
                            ),
                            Expanded(
                              child: CenterNormaltext(
                                  string:
                                      "${widget.match.goal.home} : ${widget.match.goal.away}",
                                  fontWeight: FontWeight.bold,
                                  color: accentcolor,
                                  fontsize: 26),
                            ),
                            Expanded(
                              child: Teamcard(
                                logourl: widget.match.away.logoUrl,
                                teamname: widget.match.away.name,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Normaltext(
                        string: widget.match.fixture.status.status == ""
                            ? widget.match.fixture.time
                            : widget.match.fixture.status.status,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey,
                        fontsize: 14,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          FlatButton(
                            onPressed: () {
                              setState(() {
                                tapindex = 0;
                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                          color: tapindex == 0
                                              ? accentcolor
                                              : Colors.transparent,
                                          width: 4))),
                              child: Normaltext(
                                string: "Stats",
                                fontWeight: FontWeight.w600,
                                color:
                                    tapindex == 0 ? accentcolor : Colors.grey,
                                fontsize: 12,
                              ),
                            ),
                          ),
                          FlatButton(
                            onPressed: () {
                              setState(() {
                                tapindex = 2;
                              });
                            },
                            child: Container(
                                decoration: BoxDecoration(
                                    border: Border(
                                        bottom: BorderSide(
                                            color: tapindex == 2
                                                ? accentcolor
                                                : Colors.transparent,
                                            width: 4))),
                                child: Normaltext(
                                  string: "Facts",
                                  fontWeight: FontWeight.w600,
                                  color:
                                      tapindex == 2 ? accentcolor : Colors.grey,
                                  fontsize: 12,
                                )),
                          ),
                          FlatButton(
                            onPressed: () {
                              setState(() {
                                tapindex = 1;
                              });
                            },
                            child: Container(
                                decoration: BoxDecoration(
                                    border: Border(
                                        bottom: BorderSide(
                                            color: tapindex == 1
                                                ? accentcolor
                                                : Colors.transparent,
                                            width: 4))),
                                child: Normaltext(
                                  string: "Line up",
                                  fontWeight: FontWeight.w600,
                                  color:
                                      tapindex == 1 ? accentcolor : Colors.grey,
                                  fontsize: 12,
                                )),
                          ),
                          FlatButton(
                            onPressed: () {
                              setState(() {
                                tapindex = 3;
                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                          color: tapindex == 3
                                              ? accentcolor
                                              : Colors.transparent,
                                          width: 4))),
                              child: Normaltext(
                                string: "Chat",
                                fontWeight: FontWeight.w600,
                                color:
                                    tapindex == 3 ? accentcolor : Colors.grey,
                                fontsize: 12,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                detailscreen[tapindex]
              ],
            ),
          ),
        ),
      ),
    );
  }
}
