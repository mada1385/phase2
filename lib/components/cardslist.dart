import 'package:flutter/material.dart';
import 'package:gulfgoal/config/colors.dart';
import 'package:gulfgoal/config/provider.dart';
import 'package:gulfgoal/models/match.dart';
import 'package:provider/provider.dart';

class Matchcards extends StatelessWidget {
  const Matchcards({
    Key key,
    @required this.match,
  }) : super(key: key);

  final SoccerMatch match;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: match.cards.cards.map((i) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
              width: MediaQuery.of(context).size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                // crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    flex: 4,
                    child: Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: i["home_fault"] == ""
                            ? []
                            : [
                                Flexible(
                                  child: Text(
                                    i["home_fault"],
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
                                SizedBox(
                                  width: 5,
                                ),
                                Container(
                                  height: 17,
                                  width: 13,
                                  color: i["card"] == "yellow card"
                                      ? Colors.yellow
                                      : Colors.red,
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
                                textAlign: TextAlign.center,
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
                        children: i["away_fault"] == ""
                            ? []
                            : [
                                SizedBox(
                                  width: 5,
                                ),
                                Container(
                                  height: 17,
                                  width: 13,
                                  color: i["card"] == "yellow card"
                                      ? Colors.yellow
                                      : Colors.red,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Flexible(
                                  child: Text(
                                    i["away_fault"],
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
