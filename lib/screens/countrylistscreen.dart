import 'package:connectivity_wrapper/connectivity_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:gulfgoal/components/countrylist.dart';
import 'package:gulfgoal/components/texts.dart';
import 'package:gulfgoal/config/colors.dart';
import 'package:gulfgoal/config/mediaqueryconfig.dart';
import 'package:gulfgoal/locale/locales.dart';
import 'package:gulfgoal/models/country.dart';
import 'package:gulfgoal/services/countryAPI.dart';

import 'nointernetscreen.dart';

class Countrylistscreen extends StatefulWidget {
  @override
  _CountrylistscreenState createState() => _CountrylistscreenState();
}

class _CountrylistscreenState extends State<Countrylistscreen> {
  TextEditingController controller = new TextEditingController();
  List<Country> onSearchTextChanged(String text, List<Country> fav) {
    List<Country> _searchResult = [];
    _searchResult.clear();
    if (text.isEmpty) {
      // setState(() {});
      return null;
    }

    fav.forEach((userDetail) {
      if (userDetail.country.toUpperCase().contains(text.toUpperCase()) ||
          userDetail.country.toUpperCase().contains(text.toUpperCase()))
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
        body: SafeArea(
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
                                          hintText: AppLocalizations.of(context)
                                              .search,
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
                            child: Boldaccectcolor(
                              size: 16,
                              text:
                                  AppLocalizations.of(context).choosefavcountry,
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
                              data:
                                  AppLocalizations.of(context).selectfavcountry,
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
                  future: CountryApi()
                      .getAllCountries(), //Here we will call our getData() method,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      if (onSearchTextChanged(controller.text, snapshot.data) ==
                          null)
                        return Countrylist(
                          countries: snapshot.data,
                        );
                      else
                        return Countrylist(
                          countries: onSearchTextChanged(
                              controller.text, snapshot.data),
                        );
                    } else {
                      return Expanded(
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
        ),
      ),
    );
  }
}
