import 'package:connectivity_wrapper/connectivity_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:gulfgoal/components/latestnewslist.dart';
import 'package:gulfgoal/components/texts.dart';
import 'package:gulfgoal/components/trendlist.dart';
import 'package:gulfgoal/config/colors.dart';
import 'package:gulfgoal/config/mediaqueryconfig.dart';
import 'package:gulfgoal/config/provider.dart';
import 'package:gulfgoal/locale/locales.dart';
import 'package:gulfgoal/models/tags.dart';
import 'package:gulfgoal/screens/nointernetscreen.dart';
import 'package:gulfgoal/services/newsAPI.dart';
import 'package:gulfgoal/services/tagsAPI.dart';
import 'package:gulfgoal/services/trendAPI.dart';
import 'package:provider/provider.dart';

class Newsscreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: SafeArea(
        child: //the future builder is very intersting to use when you work with api
            Newslist(),
      ),
    );
  }
}

class Newslist extends StatefulWidget {
  @override
  _NewslistState createState() => _NewslistState();
}

class _NewslistState extends State<Newslist> {
  List<Tags> generatelsit(dynamic data) {
    List<Tags> filtertags = [Tags("All categories", "All categories")];
    for (var item in data) {
      filtertags.add(item);
    }
    return filtertags;
  }

  @override
  Widget build(BuildContext context) {
    return ConnectivityWidgetWrapper(
      offlineWidget: Nointernetscreen(),
      child: FutureBuilder(
          future: NewsAPI().getAllnews(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Theme(
                data: ThemeData(accentColor: accentcolor),
                child: ListView(
                  children: [
                    Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                FutureBuilder(
                                  future: Tagsapi().getAlltags(),
                                  builder: (context, snapshots) {
                                    //the future builder is very intersting to use when you work with api
                                    if (snapshots.hasData) {
                                      List<Tags> tags =
                                          generatelsit(snapshots.data);
                                      return Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Boldaccectcolor(
                                            size: 16,
                                            text: AppLocalizations.of(context)
                                                .trendingNews,
                                          ),
                                          DropdownButton(
                                              items: tags.map((i) {
                                                return DropdownMenuItem(
                                                  value: i.tag,
                                                  child: Normaltext(
                                                    string: i.tag,
                                                    fontsize: 10,
                                                  ),
                                                );
                                              }).toList(),
                                              value: Provider.of<Userprovider>(
                                                      context)
                                                  .initvaluetrends,
                                              onChanged: (val) {
                                                setState(() {
                                                  Provider.of<Userprovider>(
                                                          context,
                                                          listen: false)
                                                      .setinitvaluetrends(val);
                                                  print(
                                                      Provider.of<Userprovider>(
                                                              context,
                                                              listen: false)
                                                          .initvaluetrends);
                                                });
                                              }),
                                        ],
                                      );
                                    } else {
                                      return Container(
                                        height: 1,
                                      );
                                    }
                                  },
                                ),
                              ],
                            ),
                          ),
                          FutureBuilder(
                            future: TrendAPI().getAlltrends(),
                            builder: (context, snapshots) {
                              //the future builder is very intersting to use when you work with api
                              if (snapshots.hasData) {
                                print((snapshots.data).length);
                                return Trendlist(
                                  news: snapshots.data,
                                  ishomescreen: false,
                                );
                              } else {
                                return Container(
                                  height: 1,
                                );
                              }
                            },
                          ), // here we will buil  =>

                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Boldaccectcolor(
                                  size: 16,
                                  text: AppLocalizations.of(context).latestNews,
                                ),
                                FutureBuilder(
                                  future: Tagsapi().getAlltags(),
                                  builder: (context, snapshots) {
                                    //the future builder is very intersting to use when you work with api
                                    if (snapshots.hasData) {
                                      List<Tags> tags =
                                          generatelsit(snapshots.data);
                                      return DropdownButton(
                                          items: tags.map((i) {
                                            return DropdownMenuItem(
                                              value: i.tag,
                                              child: Normaltext(
                                                string: i.tag,
                                                fontsize: 10,
                                              ),
                                            );
                                          }).toList(),
                                          value:
                                              Provider.of<Userprovider>(context)
                                                  .initvaluenews,
                                          onChanged: (val) {
                                            setState(() {
                                              Provider.of<Userprovider>(context,
                                                      listen: false)
                                                  .setinitvaluenews(val);
                                              print(Provider.of<Userprovider>(
                                                      context,
                                                      listen: false)
                                                  .initvaluetrends);
                                            });
                                          });
                                    } else {
                                      return Container(
                                        height: 1,
                                      );
                                    }
                                  },
                                ),
                              ],
                            ),
                          ),

                          Column(
                            children: [
                              Latestnewslist(
                                news: snapshot.data,
                                ishomescreen: false,
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Center(
                    child: Theme(
                  data: Theme.of(context).copyWith(accentColor: accentcolor),
                  child: new CircularProgressIndicator(
                    backgroundColor: Colors.black26,
                  ),
                )),
              );
            }
          }),
    );
  }
}
