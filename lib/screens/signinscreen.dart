// import 'package:email_validator/email_validator.dart';
import 'package:connectivity_wrapper/connectivity_wrapper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gulfgoal/components/customtextfield.dart';
import 'package:gulfgoal/components/texts.dart';
import 'package:gulfgoal/config/colors.dart';
import 'package:gulfgoal/config/mediaqueryconfig.dart';
import 'package:gulfgoal/locale/locales.dart';
import 'package:gulfgoal/models/user.dart';
import 'package:gulfgoal/screens/forgetpasswordscreen.dart';
import 'package:gulfgoal/screens/homescreen.dart';
import 'package:gulfgoal/screens/aftersignupscreen.dart';

import 'package:gulfgoal/screens/signupscreen.dart';
import 'package:gulfgoal/services/authAPI.dart';

import 'nointernetscreen.dart';

class Signinscreen extends StatefulWidget {
  @override
  _SigninscreenState createState() => _SigninscreenState();
}

class _SigninscreenState extends State<Signinscreen> {
  final mailcontroller = TextEditingController(),
      passwordcontroller = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  bool isobsecurepass = true;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return ConnectivityWidgetWrapper(
      offlineWidget: Nointernetscreen(),
      child: Scaffold(
        body: SafeArea(
          child: Container(
            child: ListView(
              children: [
                Container(
                  height: 149,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black26,
                          blurRadius: 2,
                          offset: Offset(0, 0.75)),
                    ],
                    color: Color(0xffF2FBF9),
                  ),
                  child: Column(
                    children: [
                      Flexible(
                          child: SizedBox(
                        height: SizeConfig.blockSizeVertical * 8,
                      )),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 25),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Boldaccectcolor(
                                size: 16,
                                text: AppLocalizations.of(context).letsresume),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 25),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Contenttext(
                              data:
                                  AppLocalizations.of(context).logintocontinue,
                              size: 14,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        height: SizeConfig.blockSizeVertical * 5,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 5),
                        child: CustomTextfield(
                            controller: mailcontroller,
                            hint: AppLocalizations.of(context).writeyourEmail,
                            isobscure: false,
                            label: AppLocalizations.of(context).email,
                            priffix: Icons.mail_outline,
                            validator: 1),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: CustomTextfield(
                          suffix: GestureDetector(
                            onTap: () {
                              setState(() {
                                isobsecurepass = !isobsecurepass;
                              });
                            },
                            child: Icon(
                              Icons.remove_red_eye,
                              color: accentcolor,
                              size: 20,
                            ),
                          ),
                          controller: passwordcontroller,
                          hint: AppLocalizations.of(context).writeyourpassword,
                          isobscure: isobsecurepass,
                          label: AppLocalizations.of(context).password,
                          priffix: Icons.lock_outline,
                          validator: 0,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Container(
                          width: double.infinity,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Contenttext(
                                  data: AppLocalizations.of(context)
                                      .forgetpassword,
                                  size: 10),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              Forgetpasswordscreen()));
                                },
                                child: Boldaccectcolor(
                                  text: AppLocalizations.of(context).clickhere,
                                  size: 10,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Container(
                          width: double.infinity,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 16.0),
                            child: Snackbutton(
                                formKey: _formKey,
                                mailcontroller: mailcontroller,
                                passwordcontroller: passwordcontroller),
                          ),
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Contenttext(
                                data: AppLocalizations.of(context)
                                    .donthaveanaccount,
                                size: 12),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Signupscreen()));
                              },
                              child: Boldaccectcolor(
                                text: AppLocalizations.of(context)
                                    .createanaccount,
                                size: 12,
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Normaltext(
                            string: "Or sign in with :",
                            color: textcolor,
                            fontsize: 14,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // GestureDetector(
                          //   onTap: () async {
                          //     await Firebase.initializeApp();

                          //     await Authapi().signOutGoogle();
                          //   },
                          //   child: Image.asset(
                          //     "asset/facebook.png",
                          //     width: 40,
                          //     height: 40,
                          //   ),
                          // ),
                          SizedBox(
                            width: 20,
                          ),
                          Signinwithgoogle()
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

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

class Snackbutton extends StatelessWidget {
  const Snackbutton({
    Key key,
    @required GlobalKey<FormState> formKey,
    @required this.mailcontroller,
    @required this.passwordcontroller,
  })  : _formKey = formKey,
        super(key: key);

  final GlobalKey<FormState> _formKey;
  final TextEditingController mailcontroller;
  final TextEditingController passwordcontroller;

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      color: accentcolor,
      onPressed: () async {
        // Validate returns true if the form is valid, or false
        // otherwise.
        if (_formKey.currentState.validate()) {
          print(mailcontroller.toString());

          Users user = Users(
            mailcontroller.text,
            passwordcontroller.text,
          );
          Authapi x = Authapi();
          var signup = await x.login(user, context);

          if (signup["success"]) {
            HapticFeedback.mediumImpact();

            Scaffold.of(context).showSnackBar(SnackBar(
                elevation: 10,
                padding: EdgeInsets.symmetric(vertical: 10),
                backgroundColor: accentcolor,
                content: Container(
                    child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    signup["msg"],
                    style: TextStyle(
                        fontFamily: 'cairo',
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.w600),
                  ),
                ))));

            Future.delayed(Duration(seconds: 2), () {
              // 5s over, navigate to a new page
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => Homescreen()));
            });
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
                  child: Text(
                    signup["msg"],
                    style: TextStyle(
                        fontFamily: 'cairo',
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.w600),
                  ),
                ))));
          }
        } else {
          HapticFeedback.mediumImpact();
          Future.delayed(Duration(milliseconds: 50), () {
            // 5s over, navigate to a new page
            HapticFeedback.mediumImpact();
          });
        }
      },
      child: Normaltext(
        string: AppLocalizations.of(context).login,
        color: Colors.white,
        fontsize: 16,
      ),
    );
  }
}
