import 'dart:convert';
import 'package:http/http.dart';

class CommentApi {
  Future postcomment(String comment, String token, String newsid) async {
    print("comment posting");

    try {
      final favouriteteam = await post(
          "http://gulf-goal-backend.us-east-2.elasticbeanstalk.com/api/news/add-comment",
          body: {
            "newsId": newsid,
            "comment": comment,
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

  Future likecomment(String commentid, String token, String newsid) async {
    print("comment liking");

    try {
      final favouriteteam = await post(
          "http://gulf-goal-backend.us-east-2.elasticbeanstalk.com/api/news/like-comment",
          body: {
            "newsId": newsid,
            "commentId": commentid,
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

  Future postreply(
      String comment, String token, String newsid, String commentid) async {
    print("comment posting");
    print(newsid);

    try {
      final favouriteteam = await post(
          "http://gulf-goal-backend.us-east-2.elasticbeanstalk.com/api/news/do-reply",
          body: {
            "newsId": newsid,
            "reply": comment,
            "commentId": commentid,
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

  Future getcomments(String newsid) async {
    try {
      Response res = await get(
        "http://gulf-goal-backend.us-east-2.elasticbeanstalk.com/api/news/get-comments/$newsid",
      );
      var body = jsonDecode(res.body);
      // print(res.body);
      if (res.statusCode == 200) {
        print("comment updated sucssefuly from api");
        return body;
      } else {
        print("failed");
        return body;
      }
    } catch (e) {
      print(e);
    }
  }

  Future postmatchcomment(String comment, String token, String newsid) async {
    print("comment match posting");

    try {
      final favouriteteam = await post(
          "http://gulf-goal-backend.us-east-2.elasticbeanstalk.com/api/teams/match-comment",
          body: {
            "match_id": newsid,
            "comment": comment,
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

  Future getmatchcomments(String newsid) async {
    try {
      Response res = await get(
        "http://gulf-goal-backend.us-east-2.elasticbeanstalk.com/api/teams/get-match-comments/$newsid",
      );
      var body = jsonDecode(res.body);
      print(res.body);
      if (res.statusCode == 200) {
        print("comment updated sucssefuly from api");
        return body;
      } else {
        print("failed");
        return body;
      }
    } catch (e) {
      print(e);
    }
  }

  Future postmatchreply(
      String comment, String token, String newsid, String commentid) async {
    print("comment posting");

    try {
      final favouriteteam = await post(
          "http://gulf-goal-backend.us-east-2.elasticbeanstalk.com/api/teams/match-comment-reply",
          body: {
            "match_id": newsid,
            "reply": comment,
            "commentId": commentid,
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

  Future likematchcomment(String commentid, String token, String newsid) async {
    print("comment liking");

    try {
      final favouriteteam = await post(
          "http://gulf-goal-backend.us-east-2.elasticbeanstalk.com/api/teams/like-match-comment",
          body: {
            "match_id": newsid,
            "commentId": commentid,
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
