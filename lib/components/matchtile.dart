import 'package:flutter/material.dart';
import 'package:flutter_image/network.dart';
import 'package:gulfgoal/components/texts.dart';
import 'package:gulfgoal/config/colors.dart';
import 'package:gulfgoal/models/match.dart';

class Matchtile extends StatelessWidget {
  final SoccerMatch match;

  const Matchtile({Key key, this.match}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    ;

    var homeGoal = match.goal.home;
    var awayGoal = match.goal.away;
    var status = match.fixture.status.status;
    if (homeGoal == null) homeGoal = "0";
    if (awayGoal == null) awayGoal = "0";
    return GestureDetector(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Card(
          elevation: 10,
          child: Container(
            // height: SizeConfig.blockSizeVertical * 7,
            margin: EdgeInsets.symmetric(vertical: 12.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 4,
                      child: Column(
                        children: [
                          Image(
                              image: new NetworkImageWithRetry(
                                match.home.logoUrl,
                              ),
                              width: 32,
                              height: 32,
                              fit: BoxFit.cover),
                          CenterNormaltext(
                            string: match.home.name,
                            color: Colors.grey,
                            fontsize: 10,
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                        flex: 3,
                        child: Column(
                          children: [
                            Normaltext(
                              string: match.fixture.status.league,
                              fontsize: 8,
                            ),
                            CenterNormaltext(
                              string: status == ""
                                  ? match.fixture.time
                                  : "${homeGoal} - ${awayGoal}",
                              fontWeight: FontWeight.bold,
                              color: accentcolor,
                              fontsize: 22,
                            ),
                            Text(
                              status == "" ? "" : status,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Colors.grey,
                                fontSize: 8,
                              ),
                            ),
                          ],
                        )),
                    Expanded(
                      flex: 4,
                      child: Column(
                        children: [
                          Image(
                              image: new NetworkImageWithRetry(
                                match.away.logoUrl,
                              ),
                              width: 32,
                              height: 32,
                              fit: BoxFit.cover),
                          CenterNormaltext(
                            string: match.away.name,
                            color: Colors.grey,
                            fontsize: 10,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
