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
import 'package:gulfgoal/screens/fixedteamsscreen.dart';
import 'package:gulfgoal/screens/homescreen.dart';
import 'package:gulfgoal/screens/nointernetscreen.dart';
import 'package:gulfgoal/services/favAPI.dart';
import 'package:gulfgoal/services/teamsAPI.dart';
import 'package:provider/provider.dart';

class Localteamselection extends StatefulWidget {
  @override
  _LocalteamselectionState createState() => _LocalteamselectionState();
}

class _LocalteamselectionState extends State<Localteamselection> {
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
                                text: "Choose your favourite local teams",
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
                FutureBuilder(
                  future: TeamsAPI().getAllteams(
                      "240"), //Here we will call our getData() method,
                  builder: (context, snapshot) {
                    //the future builder is very intersting to use when you work with api
                    if (snapshot.hasData) {
                      if (onSearchTextChanged(controller.text, snapshot.data) ==
                          null)
                        return Teamslist(
                          teams: snapshot.data,
                        );
                      else
                        return Teamslist(
                          teams: onSearchTextChanged(
                              controller.text, snapshot.data),
                        );
                    } else {
                      return Expanded(
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    }
                  }, // here we will buil the app layout
                ),
              ],
            ),
          ),
        )),
      ),
    );
  }
}
