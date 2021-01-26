import 'package:flutter/material.dart';
import 'package:gulfgoal/config/provider.dart';
import 'package:gulfgoal/models/match.dart';
import 'package:gulfgoal/components/matchtile.dart';
import 'package:gulfgoal/screens/matchdetailsscreen.dart';
import 'package:provider/provider.dart';

class Fixturelist extends StatefulWidget {
  final List<SoccerMatch> allmatches;

  const Fixturelist({Key key, this.allmatches}) : super(key: key);

  @override
  _FixturelistState createState() => _FixturelistState();
}

class _FixturelistState extends State<Fixturelist> {
  int matchindex = 0;
  SoccerMatch x;
  @override
  Widget build(BuildContext context) {
    Provider.of<Userprovider>(context, listen: false)
        .setmatchdetails(widget.allmatches);
    return Expanded(
      child: Container(
        width: double.infinity,
        // decoration: BoxDecoration(
        //   color: Color(0xFF4373D9),
        //   borderRadius: BorderRadius.only(
        //     topLeft: Radius.circular(40.0),
        //     topRight: Radius.circular(40.0),
        //   ),
        // ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: ListView.builder(
                physics: const BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics()),
                itemCount: widget.allmatches.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                      onTap: () {
                        setState(() {
                          x = widget.allmatches[index];
                        });

                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MatchDetailsScreen(
                                      x: index,
                                    )));
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: Matchtile(match: widget.allmatches[index]),
                      ));
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
