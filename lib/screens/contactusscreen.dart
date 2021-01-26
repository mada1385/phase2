import 'package:connectivity_wrapper/connectivity_wrapper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gulfgoal/components/texts.dart';
import 'package:gulfgoal/config/colors.dart';
import 'package:gulfgoal/config/mediaqueryconfig.dart';
import 'package:gulfgoal/locale/locales.dart';
import 'nointernetscreen.dart';

class Contactusscreen extends StatelessWidget {
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
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Container(
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: SizeConfig.blockSizeVertical * 2.5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Boldaccectcolor(
                                text: AppLocalizations.of(context)
                                    .contactus
                                    .toString(),
                                size: 16,
                              ),
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Contenttext(
                              data: AppLocalizations.of(context).gethelp,
                              size: 14,
                            ),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: SizeConfig.blockSizeVertical * 2.5),
                          child: Card(
                            elevation: 20,
                            child: Column(
                              children: [
                                ListTile(
                                  leading: Icon(
                                    Icons.mail,
                                    color: accentcolor,
                                    size: SizeConfig.blockSizeVertical * 2.5,
                                  ),
                                  title: Contenttext(
                                      data: "support.gulfgoal@gmail.com",
                                      size: 14),
                                ),
                                ListTile(
                                  leading: Icon(
                                    Icons.phone,
                                    color: accentcolor,
                                    size: SizeConfig.blockSizeVertical * 2.5,
                                  ),
                                  title: Contenttext(
                                    data: "974 4022 6000",
                                    size: 14,
                                  ),
                                ),
                                ListTile(
                                  leading: Icon(
                                    Icons.location_on,
                                    color: accentcolor,
                                    size: SizeConfig.blockSizeVertical * 2.5,
                                  ),
                                  title: Contenttext(
                                    data: "N14Doha Qatar",
                                    size: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Boldaccectcolor(
                              text: AppLocalizations.of(context).socialMedia,
                              size: 16,
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          child: Card(
                            elevation: 20,
                            child: Column(
                              children: [
                                ListTile(
                                  leading: Icon(
                                    FontAwesomeIcons.facebookF,
                                    color: accentcolor,
                                    size: SizeConfig.blockSizeVertical * 2.5,
                                  ),
                                  title: Contenttext(
                                    data: "gulfgoalapp",
                                    size: 14,
                                  ),
                                ),
                                ListTile(
                                  leading: Icon(
                                    FontAwesomeIcons.twitter,
                                    color: accentcolor,
                                    size: SizeConfig.blockSizeVertical * 2.5,
                                  ),
                                  title: Contenttext(
                                    data: "gulfgoalapp",
                                    size: 14,
                                  ),
                                ),
                                ListTile(
                                  leading: Icon(
                                    FontAwesomeIcons.instagram,
                                    color: accentcolor,
                                    size: SizeConfig.blockSizeVertical * 2.5,
                                  ),
                                  title: Contenttext(
                                    data: "gulfgoalapp",
                                    size: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
