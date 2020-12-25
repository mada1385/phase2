import 'dart:async';
import 'package:flutter/material.dart';
import 'package:gulfgoal/components/commentmodel.dart';
import 'package:gulfgoal/config/colors.dart';
import 'package:gulfgoal/config/provider.dart';
import 'package:gulfgoal/models/comments.dart';
import 'package:gulfgoal/models/news.dart';
import 'package:provider/provider.dart';

class Commentstream extends StatefulWidget {
  const Commentstream({
    Key key,
    @required this.id,
  }) : super(key: key);
  final String id;
  @override
  _CommentstreamState createState() => _CommentstreamState();
}

class _CommentstreamState extends State<Commentstream> {
  Timer _clockTimer;

  void isstrem() {
    print("from comment newsdetails");
    setState(() {
      if (Provider.of<Userprovider>(context, listen: false).token != null) {
        Provider.of<Userprovider>(context, listen: false)
            .loadcomments(widget.id);
      }
    });
  }

  @override
  void initState() {
    Provider.of<Userprovider>(context, listen: false).loadcomments(widget.id);
    _clockTimer = Timer.periodic(Duration(seconds: 20), (_) => isstrem());
    super.initState();
  }

  void dispose() {
    // TODO: implement dispose
    super.dispose();
    // _userController.close();
    _clockTimer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream:
            Provider.of<Userprovider>(context).newscommentsController.stream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data["success"] == true) {
              List<dynamic> result = snapshot.data["comments"];
              // print("Api service: ${snapshot.data}"); // to debug
              List<Comment> comments =
                  result.map((dynamic item) => Comment.fromJson(item)).toList();
              return Commentmodel(
                newsid: widget.id,
                comments: comments,
              );
            } else {
              return Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "No comments yet !",
                      style: TextStyle(
                          fontFamily: 'cairo',
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: accentcolor),
                    ),
                  ],
                ),
              );
            }
            // return Commentmodel(
            //   replycontroller: replycontroller,
            //   //     comments: comments,
            // );
          } else {
            return Center(
                child: Theme(
              data: Theme.of(context).copyWith(accentColor: accentcolor),
              child: new CircularProgressIndicator(
                backgroundColor: Colors.black26,
              ),
            ));
          }
        });
  }
}
