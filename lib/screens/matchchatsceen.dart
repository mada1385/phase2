import 'package:flutter/material.dart';
import 'package:gulfgoal/components/sendcomment.dart';
import 'package:gulfgoal/components/matchcommentsection.dart';

class Matchchatscreen extends StatefulWidget {
  final String matchid;

  const Matchchatscreen({Key key, this.matchid}) : super(key: key);

  @override
  _MatchchatscreenState createState() => _MatchchatscreenState();
}

class _MatchchatscreenState extends State<Matchchatscreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: EdgeInsetsDirectional.only(
            start: 20,
            bottom: 20,
          ),
          child: Sendcomment(
            match: true,
            newsid: widget.matchid,
            padding: 0,
          ),
        ),
        CommentStream(matchid: widget.matchid),
      ],
    );
  }
}
