import 'package:flutter/material.dart';
import 'package:flutter_image/network.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gulfgoal/components/texts.dart';
import 'package:gulfgoal/config/colors.dart';
import 'package:gulfgoal/config/provider.dart';
import 'package:gulfgoal/screens/fixedteamsscreen.dart';
import 'package:gulfgoal/screens/homescreen.dart';
import 'package:gulfgoal/screens/localteamselection.dart';
import 'package:gulfgoal/services/favAPI.dart';
import 'package:provider/provider.dart';

class Aftersignupscreen extends StatefulWidget {
  @override
  _AftersignupscreenState createState() => _AftersignupscreenState();
}

class _AftersignupscreenState extends State<Aftersignupscreen> {
  int pageIndex = 0;
  PageController controller = PageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: PageView(
              physics: NeverScrollableScrollPhysics(),
              controller: controller,
              onPageChanged: (val) {
                setState(() {
                  pageIndex = val;
                });
              },
              children: [Localteamselection(), Fixedteamsscreen()],
            ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Container(
                height: 150,
                color: Colors.white,
                child: Column(
                  children: [
                    Container(
                      height: 60,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: Provider.of<Userprovider>(context)
                              .favteams
                              .length,
                          itemBuilder: (context, i) {
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image(
                                  image: NetworkImageWithRetry(
                                    Provider.of<Userprovider>(context)
                                        .favteams[i]
                                        .teambadge,
                                  ),
                                  fit: BoxFit.fill,
                                  height: 35,
                                  width: 35,
                                ),
                                CenterNormaltext(
                                    string: Provider.of<Userprovider>(context)
                                        .favteams[i]
                                        .teamname,
                                    fontsize: 12)
                              ],
                            );
                          }),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          margin: EdgeInsets.all(8.0),
                          height: 10,
                          width: 20,
                          decoration: BoxDecoration(
                              // shape: BoxShape.circle,
                              border: Border.all(color: accentcolor),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5)),
                              color:
                                  pageIndex == 0 ? accentcolor : Colors.white),
                        ),
                        Container(
                          margin: EdgeInsets.all(8.0),
                          height: 10,
                          width: 20,
                          decoration: BoxDecoration(
                              // shape: BoxShape.circle,
                              border: Border.all(color: accentcolor),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5)),
                              color:
                                  pageIndex == 1 ? accentcolor : Colors.white),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 43,
                          width: 100,
                          child: FlatButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Homescreen()));
                              },
                              child: Contenttext(
                                data: "Skip",
                                size: 14,
                              )),
                        ),
                        FlatButton(
                            onPressed: pageIndex == 0
                                ? () {
                                    controller.jumpToPage(1);
                                  }
                                : () {
                                    FavouriteAPI().postfavourite(
                                        Provider.of<Userprovider>(context,
                                                listen: false)
                                            .favteams,
                                        Provider.of<Userprovider>(context,
                                                listen: false)
                                            .token);
                                    Provider.of<Userprovider>(context,
                                            listen: false)
                                        .sethomecreenindex(0);
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                Homescreen()));
                                  },
                            child: Container(
                              height: 43,
                              width: 100,
                              decoration: BoxDecoration(
                                  color: accentcolor,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5))),
                              child: Center(
                                child: Text(
                                  pageIndex == 0 ? "Next" : "Finish",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontFamily:
                                          Provider.of<Userprovider>(context)
                                              .font(context)),
                                ),
                              ),
                            )),
                      ],
                    )
                  ],
                )),
          ),
        ],
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     FavouriteAPI().postfavourite(
      //         Provider.of<Userprovider>(context, listen: false).favteams,
      //         Provider.of<Userprovider>(context, listen: false).token);
      //     Navigator.pushReplacement(context,
      //         MaterialPageRoute(builder: (context) => Fixedteamsscreen()));
      //   },
      //   backgroundColor: accentcolor,
      //   child: Icon(FontAwesomeIcons.solidSave, color: Colors.white, size: 25),
      // ),
    );
  }
}
