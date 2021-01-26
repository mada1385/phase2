import 'dart:async';
import 'package:flutter/material.dart';
import 'package:gulfgoal/components/latestnewslist.dart';
import 'package:gulfgoal/components/livematchlist.dart';
import 'package:gulfgoal/components/texts.dart';
import 'package:gulfgoal/components/trendlist.dart';
import 'package:gulfgoal/config/colors.dart';
import 'package:gulfgoal/config/mediaqueryconfig.dart';
import 'package:gulfgoal/config/provider.dart';
import 'package:gulfgoal/locale/locales.dart';
import 'package:gulfgoal/models/match.dart';
import 'package:gulfgoal/services/favAPI.dart';
import 'package:gulfgoal/services/newsAPI.dart';
import 'package:gulfgoal/services/trendAPI.dart';
import 'package:provider/provider.dart';

class Homenewsscreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Theme(
      data: ThemeData(accentColor: accentcolor),
      child: ListView(
        children: [
          Container(
            // height: SizeConfig.safeBlockVertical * 300,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // Padding(
                //   padding: const EdgeInsets.symmetric(
                //       horizontal: 20, vertical: 20),
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.start,
                //     children: [
                //       Boldaccectcolor(
                //         text: "اهم الاخبار",
                //       )
                //     ],
                //   ),
                // ),
                SizedBox(
                  height: SizeConfig.blockSizeVertical * 1,
                ),
                FutureBuilder(
                  future: TrendAPI().getAlltrends(),
                  builder: (context, snapshots) {
                    //the future builder is very intersting to use when you work with api
                    if (snapshots.hasData) {
                      print((snapshots.data).length);
                      return Trendlist(
                        news: snapshots.data,
                        ishomescreen: true,
                      );
                    } else {
                      return Container(
                        height: 1,
                      );
                    }
                  },
                ),

                Livematchstream(),

                FutureBuilder(
                  future: NewsAPI().getAllnews(),
                  builder: (context, snapshots) {
                    if (snapshots.hasData) {
                      print((snapshots.data).length);
                      return Column(
                        children: [
                          Container(
                            color: Colors.transparent,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Boldaccectcolor(
                                    size: 16,
                                    text:
                                        AppLocalizations.of(context).latestNews,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Latestnewslist(
                            news: snapshots.data,
                            ishomescreen: true,
                          ),
                        ],
                      );
                    } else {
                      return Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                        child: Center(
                            child: Theme(
                          data: Theme.of(context)
                              .copyWith(accentColor: accentcolor),
                          child: new CircularProgressIndicator(
                            backgroundColor: Colors.black26,
                          ),
                        )),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Livematchstream extends StatefulWidget {
  const Livematchstream({
    Key key,
  }) : super(key: key);

  @override
  _LivematchstreamState createState() => _LivematchstreamState();
}

class _LivematchstreamState extends State<Livematchstream> {
  StreamController livegamesuserController;

  Timer _clockTimer;

  loadlivegamesdetailsDetails() async {
    livegamesuserController = new StreamController();
    FavouriteAPI()
        .getFavLiveMatches(
            Provider.of<Userprovider>(context, listen: false).token)
        .then((res) async {
      print("livegames updated from provider");
      livegamesuserController.add(res);

      // return res;
    });
  }

  void islogged() {
    if (Provider.of<Userprovider>(context, listen: false).token != null) {
      loadlivegamesdetailsDetails();
    }
  }

  void initState() {
    loadlivegamesdetailsDetails();
    _clockTimer = Timer.periodic(Duration(seconds: 20), (_) => islogged());
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
      stream: livegamesuserController.stream,
      //Here we will call our getData() method,
      builder: (context, snapshot) {
        //the future builder is very intersting to use when you work with api
        if (snapshot.hasData) {
          if (snapshot.data["success"] == true) {
            List<dynamic> matchesList = snapshot.data["result"];
            print("Api service: ${snapshot.data}"); // to debug
            List<SoccerMatch> matches = matchesList
                .map((dynamic item) => SoccerMatch.fromJson(item))
                .toList();
            return Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Boldaccectcolor(
                        text: AppLocalizations.of(context).yourTeam,
                        size: 16,
                      ),
                    ],
                  ),
                ),
                Livematchesscoreboard(
                  livematches: matches,
                ),
                SizedBox(
                  height: 5,
                )
              ],
            );
          } else {
            return Container(
              height: 1,
            );
          }
        } else {
          return Container(
            height: 1,
          );
        }
      }, // here we will buil the app layout
    );
  }
}
