import 'package:flutter/material.dart';
import 'package:gulfgoal/config/colors.dart';
import 'package:gulfgoal/config/provider.dart';
import 'package:gulfgoal/models/match.dart';
import 'package:provider/provider.dart';

class Goalscorer extends StatelessWidget {
  const Goalscorer({
    Key key,
    @required this.match,
  }) : super(key: key);

  final SoccerMatch match;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: match.goals.goals.map((i) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
              width: MediaQuery.of(context).size.width,
              // height: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                // crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    flex: 4,
                    child: Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: i["home_scorer"] == ""
                            ? []
                            : [
                                Flexible(
                                  child: Text(
                                    i["home_scorer"],
                                    textAlign: TextAlign.end,
                                    style: TextStyle(
                                        fontFamily: Provider.of<Userprovider>(
                                                context,
                                                listen: false)
                                            .font(context),
                                        color: Colors.black,
                                        fontSize: 10,
                                        fontWeight: FontWeight.normal),
                                  ),
                                ),
                                Icon(
                                  Icons.sports_soccer,
                                  color: accentcolor,
                                  size: 19,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                              ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.all(4),
                      child: Container(
                        height: 34,
                        width: 34,
                        decoration: BoxDecoration(
                            border: Border.all(color: accentcolor),
                            shape: BoxShape.circle),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Flexible(
                              child: Text(
                                i["time"],
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                    fontFamily: Provider.of<Userprovider>(
                                            context,
                                            listen: false)
                                        .font(context),
                                    color: Colors.black,
                                    fontSize: 10,
                                    fontWeight: FontWeight.normal),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child: Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: i["away_scorer"] == ""
                            ? []
                            : [
                                SizedBox(
                                  width: 5,
                                ),
                                Icon(
                                  Icons.sports_soccer,
                                  color: accentcolor,
                                  size: 19,
                                ),
                                Flexible(
                                  child: Text(
                                    i["away_scorer"],
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                        fontFamily: Provider.of<Userprovider>(
                                                context,
                                                listen: false)
                                            .font(context),
                                        color: Colors.black,
                                        fontSize: 10,
                                        fontWeight: FontWeight.normal),
                                  ),
                                ),
                              ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      }).toList(),
    );
  }
}
