import 'package:flutter/material.dart';
import 'package:flutter_image/network.dart';
import 'package:gulfgoal/components/favlist.dart';
import 'package:gulfgoal/components/texts.dart';
import 'package:gulfgoal/config/colors.dart';
import 'package:gulfgoal/config/mediaqueryconfig.dart';
import 'package:gulfgoal/config/provider.dart';
import 'package:gulfgoal/models/teams.dart';
import 'package:provider/provider.dart';

class Selectfixedteamlist extends StatelessWidget {
  final List<Teams> teams;

  const Selectfixedteamlist({
    Key key,
    @required this.teams,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Padding(
      padding: const EdgeInsets.all(10),
      child: Container(
        color: Colors.white,
        child: GridView.count(
            crossAxisCount: 3,
            children: teams.map((i) {
              return Builder(
                builder: (BuildContext context) {
                  return Customcheck(
                    team: i,
                  );
                },
              );
            }).toList()),
      ),
    ));
  }
}

class Customcheck extends StatefulWidget {
  final Teams team;

  const Customcheck({Key key, this.team}) : super(key: key);

  @override
  _CustomcheckState createState() => _CustomcheckState();
}

class _CustomcheckState extends State<Customcheck> {
  bool value = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: GestureDetector(
        onTap: () {
          setState(() {
            value = !value;
            if (value == true)
              Provider.of<Userprovider>(context, listen: false)
                  .addfav(widget.team);
            else if (value == false) {
              Provider.of<Userprovider>(context, listen: false)
                  .deletefav(widget.team);
            }
          });
        },
        child: Container(
            decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                      color: Colors.black26,
                      blurRadius: 5,
                      offset: Offset(0, 4))
                ],
                borderRadius: BorderRadius.all(Radius.circular(10)),
                color: Colors.white,
                border: Border.all(
                    color: value ? accentcolor : Colors.transparent, width: 2)),
            width: 200,
            height: MediaQuery.of(context).size.width / 7,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image(
                  image: NetworkImageWithRetry(
                    widget.team.teambadge,
                  ),
                  fit: BoxFit.fill,
                  height: 35,
                  width: 35,
                ),
                CenterNormaltext(string: widget.team.teamname, fontsize: 12)
              ],
            )),
      ),
    );
  }
}
