import 'dart:io';
import 'package:connectivity_wrapper/connectivity_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_image/network.dart';
import 'package:gulfgoal/components/profileoptioncard.dart';
import 'package:gulfgoal/components/signinchecker.dart';
import 'package:gulfgoal/components/texts.dart';
import 'package:gulfgoal/config/colors.dart';
import 'package:gulfgoal/config/provider.dart';
import 'package:gulfgoal/locale/locales.dart';
import 'package:gulfgoal/screens/contactusscreen.dart';
import 'package:gulfgoal/screens/aboutthecomapayscreen.dart';
import 'package:gulfgoal/screens/nointernetscreen.dart';
import 'package:gulfgoal/screens/termsofuse.dart';
import 'package:gulfgoal/screens/privacypolicyscreen.dart';
import 'package:gulfgoal/services/authAPI.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';

class Profileoptions extends StatefulWidget {
  @override
  _ProfileoptionsState createState() => _ProfileoptionsState();
}

class _ProfileoptionsState extends State<Profileoptions> {
  File _image;
  bool isSwitched = false;

  Future getImage() async {
    // ignore: deprecated_member_use
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = image;
      print('Image Path ${_image.path}');
    });
  }

  share(BuildContext context, String link) {
    final RenderBox box = context.findRenderObject();

    Share.share(link,
        subject: "check my new app",
        sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
  }

  @override
  Widget build(BuildContext context) {
    return ConnectivityWidgetWrapper(
      offlineWidget: Nointernetscreen(),
      child: Scaffold(
        body: SafeArea(
          child: SizedBox.expand(
            child: Container(
              child: Theme(
                data: ThemeData(accentColor: accentcolor),
                child: ListView(
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(boxShadow: [
                        BoxShadow(
                            color: Color(0xffF2F2F2),
                            blurRadius: 2,
                            offset: Offset(0, .75))
                      ], color: Colors.white),
                      child: Column(
                        // crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Provider.of<Userprovider>(context).token == null
                              ? Column(
                                  children: [
                                    SizedBox(
                                      height: 41,
                                    ),
                                    Signinchecher(),
                                  ],
                                )
                              : Column(
                                  children: [
                                    Align(
                                      child: IconButton(
                                        icon: Icon(
                                          Icons.logout,
                                          color: accentcolor,
                                        ),
                                        onPressed: () async {
                                          HapticFeedback.lightImpact();
                                          await Authapi().logout(context);
                                        },
                                      ),
                                      alignment: Alignment.topRight,
                                    ),
                                    GestureDetector(
                                      onTap: () async {
                                        await getImage();
                                        await Authapi().postimage(
                                            _image,
                                            Provider.of<Userprovider>(context,
                                                    listen: false)
                                                .token,
                                            context);
                                      },
                                      child: Container(
                                        height: 81,
                                        width: 81,
                                        child: CircleAvatar(
                                            backgroundImage: _image != null
                                                ? FileImage(_image)
                                                : Provider.of<Userprovider>(
                                                                context)
                                                            .image !=
                                                        null
                                                    ? NetworkImageWithRetry(
                                                        Provider.of<Userprovider>(
                                                                context)
                                                            .image)
                                                    : AssetImage(
                                                        "asset/nopic.jpg",
                                                      )),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Boldaccectcolor(
                                      text: Provider.of<Userprovider>(context,
                                              listen: false)
                                          .username,
                                      size: 16,
                                    ),
                                  ],
                                ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Profileoptioncard(
                          icon: Switch(
                            value: isSwitched,
                            onChanged: (value) {
                              HapticFeedback.mediumImpact();
                              setState(() {
                                isSwitched = value;
                                print(isSwitched);
                              });
                            },
                            activeTrackColor: accentcolor,
                            activeColor: accentcolor,
                          ),
                          title: AppLocalizations.of(context).pushNotifications,
                        ),
                        Profileoptioncard(
                          ontap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        Aboutthecomapayscreen()));
                          },
                          // icon: Icon(Icons.person),
                          title: AppLocalizations.of(context).companyprofile,
                        ),
                        Profileoptioncard(
                          ontap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Contactusscreen()));
                          },
                          // icon: Icon(Icons.payment),
                          title: AppLocalizations.of(context).contactus,
                        ),
                        Profileoptioncard(
                          ontap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Termsofusescreen()));
                          },
                          // icon: Icon(Icons.call),
                          title: AppLocalizations.of(context).termsofServices,
                        ),
                        Profileoptioncard(
                          ontap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        Privacypolicyscreen()));
                          },
                          // icon: Icon(Icons.payment),
                          title: AppLocalizations.of(context).termsofServices,
                        ),
                        Profileoptioncard(
                          // icon: Icon(Icons.payment),
                          title: "Share Gulf Goal",

                          ontap: () async {
                            share(context, "share my app");
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
