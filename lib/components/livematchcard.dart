import 'package:flutter/material.dart';
import 'package:gulfgoal/components/teamcard.dart';
import 'package:gulfgoal/config/colors.dart';
import 'package:gulfgoal/config/mediaqueryconfig.dart';
import 'package:gulfgoal/config/provider.dart';
import 'package:gulfgoal/models/match.dart';
import 'package:gulfgoal/screens/matchdetailsscreen.dart';
import 'package:provider/provider.dart';

class Livematchcard extends StatelessWidget {
  const Livematchcard({
    Key key,
    this.i,
  }) : super(key: key);
  final SoccerMatch i;
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return GestureDetector(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => MatchDetailsScreen()));
      },
      child: Card(
        elevation: 10,
        child: Container(
          child: Row(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Teamcard(
                  logourl: i.home.logoUrl,
                  teamname: i.home.name,
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      i.fixture.status.league,
                      style: TextStyle(
                          fontFamily:
                              Provider.of<Userprovider>(context, listen: false)
                                  .font(context),
                          fontWeight: FontWeight.w600,
                          color: Colors.grey,
                          fontSize: SizeConfig.blockSizeVertical * 1.5),
                    ),
                    Text(
                      "${i.goal.home} : ${i.goal.away}",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: accentcolor,
                        fontSize: SizeConfig.blockSizeVertical * 5,
                      ),
                    ),
                    Flexible(
                      child: Text(
                        i.fixture.status.status == ""
                            ? i.fixture.time
                            : i.fixture.status.status,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Colors.grey,
                          fontSize: SizeConfig.blockSizeVertical * 2.5,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Teamcard(
                  logourl: i.away.logoUrl,
                  teamname: i.away.name,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
