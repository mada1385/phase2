import 'package:flutter/material.dart';
import 'package:gulfgoal/config/mediaqueryconfig.dart';

class Teamcard extends StatelessWidget {
  final String teamname, logourl;
  const Teamcard({
    this.teamname,
    this.logourl,
  });

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.network(
          logourl,
          width: 41,
          height: 41,
        ),
        Flexible(
          child: Text(
            teamname,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'cairo',
              color: Colors.grey,
              fontSize: SizeConfig.blockSizeVertical * 2,
            ),
          ),
        ),
      ],
    );
  }
}
