import 'dart:convert';
import 'package:gulfgoal/models/news.dart';
import 'package:http/http.dart';

class NewsAPI {
  Future<List<News>> getAllnews() async {
    print("news api activated");
    try {
      Response res = await get(
          "http://gulf-goal-backend.us-east-2.elasticbeanstalk.com/api/news/all-news");
      var body;
      if (res.statusCode == 200) {
        // this mean that we are connected to the data base
        body = jsonDecode(res.body);
        print(body);
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

  Future likenews(String token, String newsid) async {
    print("news liked");
    try {
      final favouriteteam = await post(
          "http://gulf-goal-backend.us-east-2.elasticbeanstalk.com/api/news/like-news",
          body: {
            "newsId": newsid,
          },
          headers: {
            "Authorization": "bearer $token"
          });
      var body = jsonDecode(favouriteteam.body);
      print(body);
    } catch (e) {
      print(e);
      return e;
    }
  }
}
