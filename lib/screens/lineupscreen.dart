import 'package:connectivity_wrapper/connectivity_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:gulfgoal/components/texts.dart';
import 'package:gulfgoal/config/colors.dart';
import 'package:gulfgoal/config/mediaqueryconfig.dart';
import 'package:gulfgoal/models/match.dart';
import 'package:gulfgoal/screens/nointernetscreen.dart';

class Lineupscreen extends StatefulWidget {
  final SoccerMatch match;

  const Lineupscreen({Key key, this.match}) : super(key: key);

  @override
  _LineupscreenState createState() => _LineupscreenState();
}

class _LineupscreenState extends State<Lineupscreen> {
  int buttonindex = 0;
  List<dynamic> home() {
    if (buttonindex == 0) {
      return widget.match.lineup.lineuphome;
    } else
      return widget.match.lineup.lineupaway;
  }

  @override
  Widget build(BuildContext context) {
    return ConnectivityWidgetWrapper(
      offlineWidget: Nointernetscreen(),
      child: Padding(
        padding: EdgeInsets.only(right: 20, left: 20, top: 20),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Container(
                    height: 37,
                    decoration: BoxDecoration(boxShadow: [
                      BoxShadow(
                        blurRadius: 15,
                        color: Colors.black12,
                        offset: Offset(0, 2.0),
                      )
                    ], borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: FlatButton(
                      color: buttonindex == 0 ? textcolor2 : Colors.white,
                      onPressed: () {
                        setState(() {
                          buttonindex = 0;
                          print(buttonindex);
                        });
                      },
                      child: Normaltext(
                        string: widget.match.home.name,
                        fontsize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                )),
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Container(
                    height: 37,
                    decoration: BoxDecoration(boxShadow: [
                      BoxShadow(
                        blurRadius: 2,
                        color: Colors.black12,
                        offset: Offset(0, .75),
                      )
                    ], borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: FlatButton(
                      color: buttonindex == 1 ? textcolor2 : Colors.white,
                      onPressed: () {
                        setState(() {
                          buttonindex = 1;
                          print(buttonindex);
                        });
                      },
                      child: Normaltext(
                        string: widget.match.away.name,
                        fontsize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                )),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Center(
              child: Normaltext(
                string:
                    "Formation : ${buttonindex == 0 ? widget.match.lineup.formationhome : widget.match.lineup.formationaway}",
                color: textcolor2,
                fontsize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 21,
            ),
            Container(
              child: Column(
                  children: home().map((e) {
                return Builder(builder: (BuildContext context) {
                  return Container(
                      height: 58,
                      decoration: BoxDecoration(boxShadow: [
                        BoxShadow(
                          blurRadius: 2,
                          color: Colors.black26,
                          offset: Offset(0, .75),
                        )
                      ], color: Colors.white),
                      child: Column(
                        children: [
                          Expanded(
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: Normaltext(
                                    string: "${e["lineup_number"]} - ",
                                    color: textcolor2,
                                    fontsize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),

                                Normaltext(
                                  string: e["lineup_player"],
                                  color: textcolor,
                                  fontsize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                                // Text(match.lineup.lineuphome[index]["lineup_player"]),
                              ],
                            ),
                          ),
                        ],
                      ));
                });
              }).toList()),
            ),
          ],
        ),
      ),
    );
  }
}
