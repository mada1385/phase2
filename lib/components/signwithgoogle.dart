import 'package:flutter/material.dart';
import 'package:gulfgoal/components/texts.dart';
import 'package:gulfgoal/config/colors.dart';
import 'package:gulfgoal/screens/homescreen.dart';
import 'package:gulfgoal/screens/aftersignupscreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:gulfgoal/services/authAPI.dart';

class Signinwithgoogle extends StatelessWidget {
  const Signinwithgoogle({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        await Firebase.initializeApp();
        final user = await Authapi().handleSignIn(context);
        if (user['success']) {
          if (user['first_time']) {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => Aftersignupscreen()));
          } else {
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => Homescreen()));
          }
        } else {
          HapticFeedback.mediumImpact();
          Future.delayed(Duration(milliseconds: 30), () {
            // 5s over, navigate to a new page
            HapticFeedback.mediumImpact();
          });

          Scaffold.of(context).showSnackBar(SnackBar(
              elevation: 10,
              padding: EdgeInsets.symmetric(vertical: 10),
              backgroundColor: accentcolor,
              content: Container(
                  child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Normaltext(
                  string: "something went wrong",
                  color: Colors.white,
                  fontsize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ))));
        }
      },
      child: Image.asset(
        "asset/Google.png",
        width: 30,
        height: 30,
      ),
    );
  }
}
