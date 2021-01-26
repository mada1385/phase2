import 'package:connectivity_wrapper/connectivity_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image/network.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gulfgoal/components/selectfixedteamlist.dart';
import 'package:gulfgoal/components/teamslist.dart';
import 'package:gulfgoal/components/texts.dart';
import 'package:gulfgoal/config/colors.dart';
import 'package:gulfgoal/config/mediaqueryconfig.dart';
import 'package:gulfgoal/config/provider.dart';
import 'package:gulfgoal/models/teams.dart';
import 'package:gulfgoal/screens/homescreen.dart';
import 'package:gulfgoal/screens/nointernetscreen.dart';
import 'package:gulfgoal/services/favAPI.dart';
import 'package:gulfgoal/services/teamsAPI.dart';
import 'package:provider/provider.dart';

class Fixedteamsscreen extends StatefulWidget {
  @override
  _FixedteamsscreenState createState() => _FixedteamsscreenState();
}

class _FixedteamsscreenState extends State<Fixedteamsscreen> {
  TextEditingController controller = new TextEditingController();
  List<Teams> onSearchTextChanged(String text, List<Teams> fav) {
    List<Teams> _searchResult = [];
    _searchResult.clear();
    if (text.isEmpty) {
      // setState(() {});
      return null;
    }

    fav.forEach((userDetail) {
      if (userDetail.teamname.toUpperCase().contains(text.toUpperCase()) ||
          userDetail.teamname.toUpperCase().contains(text.toUpperCase()))
        _searchResult.add(userDetail);
    });

    // setState(() {});
    return _searchResult;
  }

  bool searchstate = false;
  List<Teams> teams = [
    Teams("Real Madrid",
        "https://apiv2.apifootball.com/badges/7099_real-madrid.png", "7099"),
    Teams("Barcelona",
        "https://apiv2.apifootball.com/badges/7105_barcelona.png", "7105"),
    Teams("Juventus", "https://apiv2.apifootball.com/badges/4187_juventus.png",
        "4187"),
    Teams(
        "Manchester United",
        "https://apiv2.apifootball.com/badges/2627_manchester-united.png",
        "2627"),
    Teams("Chelsea", "https://apiv2.apifootball.com/badges/2616_chelsea.png",
        "2616"),
    Teams("Liverpool",
        "https://apiv2.apifootball.com/badges/2621_liverpool.png", "2621"),
    Teams("Paris SG", "https://apiv2.apifootball.com/badges/3040_paris-sg.png",
        "3040"),
    Teams("Arsenal", "https://apiv2.apifootball.com/badges/2617_arsenal.png",
        "2617"),
    Teams("Bayern Munich",
        "https://apiv2.apifootball.com/badges/3225_bayern-munich.png", "3225"),
    Teams(
        "Manchester City",
        "https://apiv2.apifootball.com/badges/2626_manchester-city.png",
        "2626"),
    Teams("Tottenham",
        "https://apiv2.apifootball.com/badges/2628_tottenham.png", "2628"),
    Teams("Atl. Madrid",
        "https://apiv2.apifootball.com/badges/7106_atl.-madrid.png", "7106"),
    Teams("Leicester",
        "https://apiv2.apifootball.com/badges/2611_leicester.png", "2611"),
    Teams("Everton", "https://apiv2.apifootball.com/badges/2612_everton.png",
        "2612"),
    Teams("AS Roma", "https://apiv2.apifootball.com/badges/4184_as-roma.png",
        "4184"),
    Teams("AC Milan", "https://apiv2.apifootball.com/badges/4186_ac-milan.png",
        "4186"),
    Teams("Inter Milan", "https://apiv2.apifootball.com/badges/4189_inter.png",
        "4189"),
    Teams("Atalanta", "https://apiv2.apifootball.com/badges/4181_atalanta.png",
        "4181"),
    Teams(
        "Lazio", "https://apiv2.apifootball.com/badges/4183_lazio.png", "4183"),
    Teams("Dortmund", "https://apiv2.apifootball.com/badges/3230_dortmund.png",
        "3230"),
    Teams("Lyon", "https://apiv2.apifootball.com/badges/3026_lyon.png", "3026"),
  ];
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return ConnectivityWidgetWrapper(
      offlineWidget: Nointernetscreen(),
      child: Scaffold(
        body: SizedBox.expand(
            child: SafeArea(
          child: Container(
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  height: searchstate == false ? 119 : 219,
                  child: Column(
                    children: [
                      Container(
                        height: searchstate == false
                            ? SizeConfig.blockSizeVertical * 0
                            : SizeConfig.blockSizeVertical * 10,
                        color: Color(0xffF2FBF9),
                        child: searchstate == false
                            ? null
                            : new Padding(
                                padding: EdgeInsets.all(
                                    SizeConfig.blockSizeVertical * 1),
                                child: new Card(
                                  child: new ListTile(
                                    leading: Icon(Icons.search, size: 24),
                                    title: new TextField(
                                      controller: controller,
                                      decoration: new InputDecoration(
                                          hintText: 'Search',
                                          border: InputBorder.none),
                                    ),
                                    // trailing: new IconButton(
                                    //   icon: new Icon(
                                    //     Icons.cancel,
                                    //     size: searchstate == false ? 0 : 25,
                                    //   ),
                                    //   onPressed: () {
                                    //     controller.clear();
                                    //   },
                                    // ),
                                  ),
                                ),
                              ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 28,
                            ),
                            child: Container(
                              width: MediaQuery.of(context).size.width / 2,
                              child: Boldaccectcolor(
                                size: 16,
                                text: "Choose your favourite popular teams",
                              ),
                            ),
                          ),
                          Padding(
                              padding: EdgeInsets.only(
                                  left: SizeConfig.blockSizeVertical * 2.5,
                                  top: SizeConfig.blockSizeVertical * 2.5),
                              child: IconButton(
                                icon: Icon(
                                  searchstate == false
                                      ? Icons.search
                                      : Icons.close,
                                  size: SizeConfig.blockSizeVertical * 4,
                                ),
                                onPressed: () {
                                  setState(() {
                                    searchstate = !searchstate;
                                    controller.clear();
                                  });
                                },
                                color: accentcolor,
                                iconSize: SizeConfig.blockSizeVertical * 4,
                              ))
                        ],
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 28),
                            child: Contenttext(
                              data: "select your teams",
                              size: 14,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black26,
                          blurRadius: 2,
                          offset: Offset(0, 0.75)),
                    ],
                    color: Color(0xffF2FBF9),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),

                //the future builder is very intersting to use when you work with api
                Container(
                    child: onSearchTextChanged(controller.text, teams) == null
                        ? Teamslist(
                            teams: teams,
                          )
                        : Teamslist(
                            teams: onSearchTextChanged(controller.text, teams),
                          )),
              ],
            ),
          ),
        )),
        // floatingActionButton: FloatingActionButton(
        //   onPressed: () {
        //     FavouriteAPI().postfavourite(
        //         Provider.of<Userprovider>(context, listen: false).favteams,
        //         Provider.of<Userprovider>(context, listen: false).token);
        //     Navigator.pushReplacement(
        //         context, MaterialPageRoute(builder: (context) => Homescreen()));
        //   },
        //   backgroundColor: accentcolor,
        //   child:
        //       Icon(FontAwesomeIcons.solidSave, color: Colors.white, size: 25),
        // ),
      ),
    );
  }
}
