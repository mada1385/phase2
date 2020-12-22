import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gulfgoal/components/goalscorerlist.dart';
import 'package:gulfgoal/components/cardslist.dart';
import 'package:gulfgoal/models/match.dart';

class Matchfactsscreen extends StatelessWidget {
  final SoccerMatch match;

  const Matchfactsscreen({Key key, this.match}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Goalscorer(match: match),
        Matchcards(match: match),
      ],
    );
  }
}
