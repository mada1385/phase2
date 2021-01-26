import 'package:flutter/material.dart';
import 'package:gulfgoal/config/mediaqueryconfig.dart';
import 'package:gulfgoal/config/provider.dart';
import 'package:provider/provider.dart';

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
        Hero(
          // transitionOnUserGestures: true,
          tag: logourl,
          child: Image.network(
            logourl,
            width: 41,
            height: 41,
          ),
        ),
        Flexible(
          child: Text(
            teamname,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: Provider.of<Userprovider>(context, listen: false)
                  .font(context),
              color: Colors.grey,
              fontSize: SizeConfig.blockSizeVertical * 2,
            ),
          ),
        ),
      ],
    );
  }
}
