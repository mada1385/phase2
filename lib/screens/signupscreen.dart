import 'package:connectivity_wrapper/connectivity_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gulfgoal/components/customtextfield.dart';
import 'package:gulfgoal/components/texts.dart';
import 'package:gulfgoal/config/colors.dart';
import 'package:gulfgoal/config/mediaqueryconfig.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:gulfgoal/config/provider.dart';
import 'package:gulfgoal/locale/locales.dart';
import 'package:gulfgoal/models/user.dart';
import 'package:gulfgoal/screens/aftersignupscreen.dart';
import 'package:gulfgoal/screens/countrylistscreen.dart';
import 'package:gulfgoal/screens/localteamselection.dart';
import 'package:gulfgoal/screens/nointernetscreen.dart';
import 'package:gulfgoal/screens/signinscreen.dart';
import 'package:gulfgoal/services/authAPI.dart';
import 'package:provider/provider.dart';

class Signupscreen extends StatefulWidget {
  @override
  _SignupscreenState createState() => _SignupscreenState();
}

class _SignupscreenState extends State<Signupscreen> {
  final mailcontroller = TextEditingController(),
      usernamecontroller = TextEditingController(),
      confirmpasswordcontroller = TextEditingController(),
      passwordcontroller = TextEditingController();
  bool isobsecurepass = true, isobsecureCpass = true;

  final _formKey = GlobalKey<FormState>();
  String password;
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
                        height: 71,
                      )),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 25),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Boldaccectcolor(
                              text: AppLocalizations.of(context).letsgetstarted,
                              size: 16,
                            ),
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
                              data: AppLocalizations.of(context)
                                  .createanaccounttocontinue,
                              size: 14,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        height: 30,
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
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 5),
                        child: CustomTextfield(
                            controller: usernamecontroller,
                            hint:
                                AppLocalizations.of(context).writeyourusername,
                            isobscure: false,
                            label: AppLocalizations.of(context).username,
                            priffix: Icons.person_outline,
                            validator: 0),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 5),
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
                          validator: 2,
                        ),
                      ),
                      Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 5),
                          child: TextFormField(
                            onChanged: (val) => password = val,
                            controller: confirmpasswordcontroller,
                            obscureText: isobsecureCpass,
                            decoration: new InputDecoration(
                                suffix: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      isobsecureCpass = !isobsecureCpass;
                                    });
                                  },
                                  child: Icon(
                                    Icons.remove_red_eye,
                                    color: accentcolor,
                                    size: 20,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                    borderSide:
                                        new BorderSide(color: accentcolor)),
                                border: new OutlineInputBorder(
                                    borderSide:
                                        new BorderSide(color: accentcolor)),
                                hintText: AppLocalizations.of(context)
                                    .confirmyourpassword,
                                labelText: AppLocalizations.of(context)
                                    .confirmpassword,
                                labelStyle: TextStyle(
                                  color: textcolor,
                                  fontFamily: Provider.of<Userprovider>(context,
                                          listen: false)
                                      .font(context),
                                ),
                                prefixIcon: Icon(
                                  Icons.lock_outline,
                                  color: accentcolor,
                                ),
                                prefixText: ' ',
                                // suffix: ,
                                suffixStyle:
                                    const TextStyle(color: accentcolor)),
                            validator: (val) => MatchValidator(
                                    errorText: AppLocalizations.of(context)
                                        .passwordsdonotmatch)
                                .validateMatch(confirmpasswordcontroller.text,
                                    passwordcontroller.text),
                          )),
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 20, right: 20, top: 15),
                        child: Container(
                          child: Row(
                            children: [
                              Icon(
                                Icons.check_circle_outline,
                                color: accentcolor,
                                size: 16,
                              ),
                              Container(
                                width: 14,
                              ),
                              Normaltext(
                                string: AppLocalizations.of(context)
                                    .bycreatinganaccountyouagreetoour,
                                fontsize: 10,
                              ),
                            ],
                          ),
                          width: double.infinity,
                        ),
                      ),
                      Signupsnackbutton(
                          formKey: _formKey,
                          mailcontroller: mailcontroller,
                          passwordcontroller: passwordcontroller,
                          usernamecontroller: usernamecontroller),
                      Container(
                        width: double.infinity,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Contenttext(
                                data: AppLocalizations.of(context)
                                    .alreadyhaveanaccount,
                                size: 10),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Signinscreen()));
                              },
                              child: Boldaccectcolor(
                                text: AppLocalizations.of(context).login,
                                size: 10,
                              ),
                            )
                          ],
                        ),
                      ),
                      // SizedBox(
                      //   height: 25,
                      // ),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.center,
                      //   children: [
                      //     Text(
                      //       "او انشأ حساب بواسطة",
                      //       style: TextStyle(
                      //           color: textcolor,
                      //           fontSize: 20,
                      //           fontWeight: FontWeight.bold),
                      //     ),
                      //   ],
                      // ),
                      // SizedBox(
                      //   height: 20,
                      // ),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.center,
                      //   children: [
                      //     GestureDetector(
                      //       child: Image.asset(
                      //         "asset/facebook.png",
                      //         width: 40,
                      //         height: 40,
                      //       ),
                      //     ),
                      //     SizedBox(
                      //       width: 20,
                      //     ),
                      //     GestureDetector(
                      //       onTap: () async {
                      //         final user = await Authapi().handleSignIn(context);
                      //         if (user.uid != null) {
                      //           Navigator.pushReplacement(
                      //               context,
                      //               MaterialPageRoute(
                      //                   builder: (context) =>
                      //                       Countrylistscreen()));
                      //         }
                      //       },
                      //       child: Image.asset(
                      //         "asset/Google.png",
                      //         width: 40,
                      //         height: 40,
                      //       ),
                      //     )
                      //   ],
                      // ),
                      SizedBox(
                        height: 20,
                      )
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

class Signupsnackbutton extends StatelessWidget {
  const Signupsnackbutton({
    Key key,
    @required GlobalKey<FormState> formKey,
    @required this.mailcontroller,
    @required this.passwordcontroller,
    @required this.usernamecontroller,
  })  : _formKey = formKey,
        super(key: key);

  final GlobalKey<FormState> _formKey;
  final TextEditingController mailcontroller;
  final TextEditingController passwordcontroller;
  final TextEditingController usernamecontroller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: FlatButton(
            color: accentcolor,
            onPressed: () async {
              // Validate returns true if the form is valid, or false
              // otherwise.
              if (_formKey.currentState.validate()) {
                print(mailcontroller.toString());
                Users user = Users(mailcontroller.text, passwordcontroller.text,
                    username: usernamecontroller.text);
                Authapi x = Authapi();
                var signup = await x.register(user, context);

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
                              fontFamily: Provider.of<Userprovider>(context,
                                      listen: false)
                                  .font(context),
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.w600),
                        ),
                      ))));
                  Future.delayed(Duration(seconds: 1), () {
                    // 5s over, navigate to a new page
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Aftersignupscreen()));
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
                Future.delayed(Duration(milliseconds: 30), () {
                  // 5s over, navigate to a new page
                  HapticFeedback.mediumImpact();
                });
              }
            },
            child: Text(
              AppLocalizations.of(context).createAccount,
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'cairo',
              ),
            ),
          ),
        ),
      ),
    );
  }
}
