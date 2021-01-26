import 'dart:async';
import 'package:flutter/material.dart';
import 'package:gulfgoal/components/texts.dart';
import 'package:gulfgoal/components/matchchatmodel.dart';
import 'package:gulfgoal/config/colors.dart';
import 'package:gulfgoal/config/provider.dart';
import 'package:gulfgoal/locale/locales.dart';
import 'package:gulfgoal/models/comments.dart';
import 'package:provider/provider.dart';

class CommentStream extends StatefulWidget {
  const CommentStream({
    Key key,
    @required this.matchid,
  }) : super(key: key);

  final String matchid;

  @override
  _CommentStreamState createState() => _CommentStreamState();
}

class _CommentStreamState extends State<CommentStream> {
  Timer _clockTimer;
  void isstrem() {
    print("from comment newsdetails");
    setState(() {
      if (Provider.of<Userprovider>(context, listen: false).token != null) {
        Provider.of<Userprovider>(context, listen: false)
            .loadmatchcomments(widget.matchid);
      }
    });
  }

  @override
  void initState() {
    Provider.of<Userprovider>(context, listen: false)
        .loadmatchcomments(widget.matchid);
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
            Provider.of<Userprovider>(context).matchcommentsController.stream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data["success"] == true) {
              List<dynamic> result = snapshot.data["comments"];
              // print("Api service: ${snapshot.data}"); // to debug
              List<Comment> comments =
                  result.map((dynamic item) => Comment.fromJson(item)).toList();
              return Matchchatmodel(
                matchid: widget.matchid,
                comments: comments,
              );
            } else {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Boldaccectcolor(
                    text: AppLocalizations.of(context).nocommentsye,
                    size: 20,
                  ),
                ],
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
