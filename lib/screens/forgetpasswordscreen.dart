import 'package:connectivity_wrapper/connectivity_wrapper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gulfgoal/components/customtextfield.dart';
import 'package:gulfgoal/components/texts.dart';
import 'package:gulfgoal/config/colors.dart';
import 'package:gulfgoal/config/mediaqueryconfig.dart';

import 'nointernetscreen.dart';

class Forgetpasswordscreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final mailcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return ConnectivityWidgetWrapper(
      offlineWidget: Nointernetscreen(),
      child: Scaffold(
        body: ListView(
          children: [
            Container(
              height: 303,
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
                    height: 66,
                  )),
                  Image.asset(
                    "asset/lock@3x.png",
                    height: 144,
                    width: 144,
                  ),
                  Flexible(
                      child: SizedBox(
                    height: SizeConfig.blockSizeVertical * 3,
                  )),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 25),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Boldaccectcolor(text: "Forget password", size: 16),
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
                          data: "We will send your password to your email",
                          size: 14,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              child: Form(
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
                          hint: "Write your Email",
                          isobscure: false,
                          label: "Email",
                          priffix: Icons.mail_outline,
                          validator: 1),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Container(
                        width: double.infinity,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16.0),
                          child: FlatButton(
                            color: accentcolor,
                            onPressed: () async {},
                            child: Normaltext(
                              string: 'Send password',
                              color: Colors.white,
                              fontsize: 16,
                            ),
                          ),
                        ),
                      ),
                    ),
                    // SizedBox(
                    //   height: 25,
                    // ),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.center,
                    //   children: [
                    //     Text(
                    //       "او سجل دخول بواسطة : ",
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
                    //       child: Image.asset(
                    //         "asset/Google.png",
                    //         width: 40,
                    //         height: 40,
                    //       ),
                    //     )
                    //   ],
                    // ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
