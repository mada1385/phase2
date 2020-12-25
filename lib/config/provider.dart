import 'dart:async';
import 'package:flutter/material.dart';
import 'package:gulfgoal/models/news.dart';
import 'package:gulfgoal/models/teams.dart';
import 'package:gulfgoal/services/comments.dart';
import 'package:gulfgoal/services/favAPI.dart';
import 'package:gulfgoal/services/footballapi.dart';
import 'package:gulfgoal/services/trendAPI.dart';
import 'package:intl/intl.dart';

class Userprovider extends ChangeNotifier {
  String initvaluenews = "All categories";
  String initvaluetrends = "All categories";
  String token, username;
  int leaugeindex = 0, gamescreenindex = 0;
  List<Teams> favteams = List<Teams>();
  List<News> allnews = List<News>();
  List<News> alltrends = List<News>();
  bool issigningup = false;
  StreamController newscommentsController;
  StreamController allgamesuserController;
  StreamController livegamesuserController;
  StreamController favgamesuserController;
  DateFormat formatter = DateFormat('yyyy-MM-dd');
  DateTime selectedDate = DateTime.now().subtract(Duration(days: 0));
  DateTime currentdate = DateTime.now().subtract(Duration(days: 0));
  List<String> leagueid = [null, null, "468", "148", "262", "195", "589"];
  List<Teams> sortfavteams;
  void getfav() async {
    sortfavteams = await FavouriteAPI().getfavourite(token);
  }

  void issign(bool x) {
    issigningup = x;
  }

  List<String> leaguestripe;
  List<String> notliveleague = [
    "★  Favourite",
    "All games",
    "La Liga",
    "Premiere League",
    "Serie A",
    "Bundesliga",
    "Champions League"
  ];

  void islive() {
    if (formatter.format(selectedDate) == formatter.format(currentdate)) {
      leaguestripe = notliveleague;
      notifyListeners();
    } else {
      leaguestripe = notliveleague;
      notifyListeners();
    }
  }

  void setallnews(List<News> userindex) {
    allnews = userindex;
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

  void setdate(DateTime userdate) {
    print(userdate);
    selectedDate = userdate;
    notifyListeners();
  }

  void settoken(String usertoken) {
    token = usertoken;
    notifyListeners();
  }

  void setusername(String usern) {
    username = usern;
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
    favteams.removeAt(favteams.indexOf(favteam));
    notifyListeners();
    for (var team in favteams) {
      print(team.teamname);
    }
  }

  loadAllgamesdetailsDetails() async {
    allgamesuserController = new StreamController();
    SoccerApi()
        .getAllMatches(leagueid[leaugeindex], formatter.format(selectedDate))
        .then((res) async {
      print("Allgamesdetails updated from provider");
      allgamesuserController.add(res);
      notifyListeners();
      return res;
    });
  }

  loadlivegamesdetailsDetails() async {
    livegamesuserController = new StreamController();
    FavouriteAPI().getFavLiveMatches(token).then((res) async {
      print("livegames updated from provider");
      livegamesuserController.add(res);
      notifyListeners();
      // return res;
    });
  }

  loadfavgamesdetailsDetails() async {
    favgamesuserController = new StreamController();
    FavouriteAPI()
        .getFavMatches(token, formatter.format(selectedDate))
        .then((res) async {
      print("favgames updated from provider");
      favgamesuserController.add(res);
      notifyListeners();
      return res;
    });
  }

  loadcomments(String newsid) async {
    newscommentsController = new StreamController();
    CommentApi().getcomments(newsid).then((res) async {
      print("loadcomments updated from provider");
      newscommentsController.add(res);
      notifyListeners();
      // return res;
    });
  }
}
