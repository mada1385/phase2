import 'dart:convert';
import 'package:http/http.dart';

class CommentApi {
  Future postcomment(String comment, String token, String newsid) async {
    print("comment posting");

    try {
      final favouriteteam = await post(
          "http://gulf-goal.herokuapp.com/api/news/add-comment",
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

  Future postreply(
      String comment, String token, String newsid, String commentid) async {
    print("comment posting");

    try {
      final favouriteteam =
          await post("http://gulf-goal.herokuapp.com/api/news/do-reply", body: {
        "newsId": newsid,
        "reply": comment,
        "commentId": commentid,
      }, headers: {
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
        "http://gulf-goal.herokuapp.com/api/news/get-comments/$newsid",
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
}
