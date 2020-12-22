import 'package:flutter/material.dart';
import 'package:gulfgoal/components/standingslist.dart';
import 'package:gulfgoal/components/texts.dart';
import 'package:gulfgoal/config/mediaqueryconfig.dart';

class Standinglist extends StatefulWidget {
  final List data;

  const Standinglist({Key key, this.data}) : super(key: key);
  @override
  _StandinglistState createState() => _StandinglistState();
}

class _StandinglistState extends State<Standinglist> {
  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Container(
        height: SizeConfig.blockSizeVertical * 72,
        decoration: BoxDecoration(boxShadow: <BoxShadow>[
          BoxShadow(
              color: Colors.black12, blurRadius: 15.0, offset: Offset(0.0, .75))
        ], color: Colors.white),
        child: ListView(
          physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics()),
          children: [
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
              child: Row(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        Normaltext(
                          string: 'Pos',
                          fontsize: 10,
                          fontWeight: FontWeight.w500,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Normaltext(
                          string: 'Club',
                          fontsize: 10,
                          fontWeight: FontWeight.w500,
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Normaltext(
                          string: 'PL',
                          fontsize: 10,
                          fontWeight: FontWeight.w500,
                        ),
                        Normaltext(
                          string: 'W',
                          fontsize: 10,
                          fontWeight: FontWeight.w500,
                        ),
                        Normaltext(
                          string: 'D',
                          fontsize: 10,
                          fontWeight: FontWeight.w500,
                        ),
                        Normaltext(
                          string: 'L',
                          fontsize: 10,
                          fontWeight: FontWeight.w500,
                        ),
                        Normaltext(
                          string: 'Gf',
                          fontsize: 10,
                          fontWeight: FontWeight.w500,
                        ),
                        Normaltext(
                          string: 'GA',
                          fontsize: 10,
                          fontWeight: FontWeight.w500,
                        ),
                        Normaltext(
                          string: 'Pts',
                          fontsize: 10,
                          fontWeight: FontWeight.w500,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            buildTable(widget.data),
          ],
        ),
      ),
    );
  }
}
