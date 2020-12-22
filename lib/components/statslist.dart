import 'package:flutter/material.dart';
import 'package:gulfgoal/components/statrow.dart';
import 'package:gulfgoal/models/match.dart';

class Stats extends StatelessWidget {
  const Stats({
    Key key,
    @required this.match,
  }) : super(key: key);

  final SoccerMatch match;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: match.stats.stats.map((i) {
        return Builder(
          builder: (BuildContext context) {
            return Statrow(match: i);
          },
        );
      }).toList(),
    );
  }
}
