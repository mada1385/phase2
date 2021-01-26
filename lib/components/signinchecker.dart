import 'package:flutter/material.dart';
import 'package:gulfgoal/components/texts.dart';
import 'package:gulfgoal/config/colors.dart';
import 'package:gulfgoal/locale/locales.dart';
import 'package:gulfgoal/screens/signinscreen.dart';
import 'package:gulfgoal/screens/signupscreen.dart';

class Signinchecher extends StatelessWidget {
  const Signinchecher({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 41,
              width: 101,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  // boxShadow: [
                  //   BoxShadow(
                  //       blurRadius: 2,
                  //       color: Colors.black26,
                  //       offset: Offset(0, .75))
                  // ],
                  // borderRadius: BorderRadius.all(Radius.circular(5)),
                  color: accentcolor),
              child: FlatButton(
                color: Colors.transparent,
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Signinscreen()));
                },
                child: CenterNormaltext(
                  string: AppLocalizations.of(context).signin,
                  fontsize: 14,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(
              width: 20,
            ),
            Container(
              height: 41,
              width: 101,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  // boxShadow: [
                  //   BoxShadow(
                  //       blurRadius: 2,
                  //       color: Colors.black26,
                  //       offset: Offset(0, .75))
                  // ],
                  // borderRadius: BorderRadius.all(Radius.circular(5)),
                  color: Color(0xffE5EAE9)),
              child: FlatButton(
                color: Colors.transparent,
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Signupscreen()));
                },
                child: CenterNormaltext(
                  string: AppLocalizations.of(context).signup,
                  fontsize: 14,
                  color: accentcolor,
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 5,
        ),
        Normalaccecttext(
          size: 18,
          text: AppLocalizations.of(context).pleasesignintocontinue,
        ),
        SizedBox(
          height: 20,
        )
      ],
    );
  }
}
