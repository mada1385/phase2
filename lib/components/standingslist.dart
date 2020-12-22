import 'package:flutter/material.dart';
import 'package:gulfgoal/components/texts.dart';
import 'package:gulfgoal/config/colors.dart';

Widget buildTable(List _table) {
  List<Widget> teams = [];
  for (var team in _table) {
    teams.add(
      Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            Expanded(
              child: Row(
                children: [
                  team['overall_league_position'].toString().length > 1
                      ? Text(team['overall_league_position'].toString() + ' - ')
                      : Text(" " +
                          team['overall_league_position'].toString() +
                          ' - '),
                  Row(
                    children: [
                      Image.network(
                        team['team_badge'],
                        height: 32,
                        width: 32,
                      ),
                      team['team_name'].toString().length > 11
                          ? Normaltext(
                              string: team['team_name']
                                      .toString()
                                      .substring(0, 11) +
                                  '...',
                              fontsize: 10,
                            )
                          : Normaltext(
                              string: team['team_name'].toString(),
                              fontsize: 10,
                            ),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Normaltext(
                    string: team['overall_league_payed'].toString(),
                    fontsize: 10,
                  ),
                  Normaltext(
                    string: team['overall_league_W'].toString(),
                    fontsize: 10,
                  ),
                  Normaltext(
                    string: team['overall_league_D'].toString(),
                    fontsize: 10,
                  ),
                  Normaltext(
                    string: team['overall_league_L'].toString(),
                    fontsize: 10,
                  ),
                  Normaltext(
                    string: team['overall_league_GF'].toString(),
                    fontsize: 10,
                  ),
                  Normaltext(
                    string: team['overall_league_GA'].toString(),
                    fontsize: 10,
                  ),
                  Normaltext(
                    fontsize: 10,
                    string: team['overall_league_PTS'].toString(),
                    color: accentcolor,
                    fontWeight: FontWeight.w500,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  return Column(
    children: teams,
  );
}
