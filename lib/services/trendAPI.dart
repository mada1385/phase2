import 'dart:convert';
import 'package:gulfgoal/models/news.dart';
import 'package:http/http.dart';

class TrendAPI {
  Future<List<News>> getAlltrends() async {
    print("trend api activated");

    try {
      Response res = await get(
          "http://gulf-goal-backend.us-east-2.elasticbeanstalk.com/api/news/all-trends");
      print(res.statusCode);
      var body;
      if (res.statusCode == 200) {
        // this mean that we are connected to the data base
        body = jsonDecode(res.body);
        if (res.body.length > 1) {
          List<dynamic> newsdata = body;
          List<News> news =
              newsdata.map((dynamic item) => News.fromJson(item)).toList();
          return news;
        } else {
          return null;
        }
      }
    } catch (e) {
      print(e);
    }
  }
}
