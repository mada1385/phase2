import 'dart:async';
import 'package:flutter/material.dart';

import 'package:gulfgoal/models/news.dart';
import 'package:gulfgoal/models/match.dart';

import 'package:gulfgoal/models/teams.dart';
import 'package:gulfgoal/services/commentsAPI.dart';
import 'package:gulfgoal/services/favAPI.dart';
import 'package:gulfgoal/services/footballapi.dart';
import 'package:gulfgoal/services/newsAPI.dart';
import 'package:intl/intl.dart';

class Userprovider extends ChangeNotifier {
  List<SoccerMatch> match;

  String initvaluenews = "All categories";
  String initvaluetrends = "All categories";
  String token, username, id, image;
  int leaugeindex = 0, gamescreenindex = 0, homescreenindex = 0;
  List<Teams> favteams = List<Teams>();
  List<News> allnews = List<News>();
  List<News> alltrends = List<News>();
  bool issigningup = false;
  StreamController killercontroller;

  StreamController matchcommentsController;
  StreamController newscommentsController;
  StreamController allgamesuserController;
  StreamController favgamesuserController;
  DateFormat formatter = DateFormat('yyyy-MM-dd', "en");
  DateTime selectedDate = DateTime.now().subtract(Duration(days: 0));
  DateTime currentdate = DateTime.now().subtract(Duration(days: 0));
  List<String> leagueid = [
    null,
    null,
    "240",
    "468",
    "148",
    "262",
    "195",
    "176",
    "589"
  ];
  List<Teams> sortfavteams;

  void getfav() async {
    sortfavteams = await FavouriteAPI().getfavourite(token);
  }

  void issign(bool x) {
    issigningup = x;
  }

  String font(BuildContext context) {
    if (Localizations.localeOf(context).languageCode.contains('ar')) {
      return 'cairo';
    } else {
      return 'poppins';
    }
  }

  List<String> notliveleague = [
    "★  Favourite",
    "All games",
    "ISL",
    "La Liga",
    "Premiere League",
    "Serie A",
    "Bundesliga",
    "ligue1",
    "UCL"
  ];

  bool isliked(List likeduser) {
    bool x = false;
    if (id != null) {
      for (var userDetail in likeduser) {
        if (userDetail.contains(id)) {
          x = true;
          break;
        }
      }
    }
    return x;
  }

  void setallnews(List<News> userindex) {
    allnews = userindex;
    notifyListeners();
  }

  void setmatchdetails(List<SoccerMatch> newmatch) {
    match = newmatch;
    notifyListeners();
  }

  void setalltrends(List<News> userindex) {
    alltrends = userindex;
    notifyListeners();
  }

  void setinitvaluenews(String userindex) {
    initvaluenews = userindex;
    notifyListeners();
  }

  void setleaugeindex(int userindex) {
    leaugeindex = userindex;
    notifyListeners();
  }

  void setinitvaluetrends(String userindex) {
    initvaluetrends = userindex;
    notifyListeners();
  }

  void setgamescreenindex(int userindex) {
    gamescreenindex = userindex;
    notifyListeners();
  }

  void sethomecreenindex(int userindex) {
    homescreenindex = userindex;
    notifyListeners();
  }

  void setdate(DateTime userdate) {
    print(userdate);
    selectedDate = userdate;
    notifyListeners();
  }

  void settoken(String usertoken) {
    token = usertoken;
    notifyListeners();
  }

  void setid(String usertoken) {
    id = usertoken;
    notifyListeners();
  }

  void setusername(String usern) {
    username = usern;
    notifyListeners();
  }

  void setimage(String usern) {
    image = usern;
    notifyListeners();
  }

  void addfav(Teams favteam) {
    favteams.add(favteam);
    notifyListeners();
    for (var team in favteams) {
      print(team.teamname);
    }
  }

  void deletefav(Teams favteam) {
    if (favteams.length == 1)
      favteams.clear();
    else
      favteams.removeAt(favteams.indexOf(favteam));
    notifyListeners();
    for (var team in favteams) {
      print(team.teamname);
    }
    notifyListeners();
  }

  loadAllgamesdetailsDetails() async {
    allgamesuserController = new StreamController.broadcast();
    SoccerApi()
        .getAllMatches(leagueid[leaugeindex], formatter.format(selectedDate))
        .then((res) async {
      print("Allgamesdetails updated from provider");
      allgamesuserController.add(res);
      notifyListeners();
      return res;
    });
  }

  loadfavgamesdetailsDetails() {
    favgamesuserController = new StreamController.broadcast();
    FavouriteAPI()
        .getFavMatches(token, formatter.format(selectedDate))
        .then((res) {
      print("favgames updated from provider");
      favgamesuserController.add(res);
      notifyListeners();
      return res;
    });
  }

  killfavstream() {
    newscommentsController.add(null);
    notifyListeners();
  }

  loadcomments(String newsid) async {
    newscommentsController = new StreamController.broadcast();
    CommentApi().getcomments(newsid).then((res) async {
      print("loadcomments updated from provider");
      newscommentsController.add(res);
      notifyListeners();
      // return res;
    });
  }

  loadmatchcomments(String newsid) async {
    matchcommentsController = new StreamController.broadcast();
    CommentApi().getmatchcomments(newsid).then((res) async {
      print("loadcomments updated from provider");
      matchcommentsController.add(res);
      notifyListeners();
      // return res;
    });
  }

  // loadnews() async {
  //   newsController = new StreamController();
  //   NewsAPI().getAllnews().then((res) async {
  //     print("loadcomments updated from provider");
  //     newsController.add(res);
  //     notifyListeners();
  //     // return res;
  //   });
  // }
}
