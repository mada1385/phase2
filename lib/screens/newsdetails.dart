import 'package:connectivity_wrapper/connectivity_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image/network.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gulfgoal/components/commentmodel.dart';
import 'package:gulfgoal/components/commentstream.dart';
import 'package:gulfgoal/components/sendcomment.dart';
import 'package:gulfgoal/components/latestnewslist.dart';
import 'package:gulfgoal/components/texts.dart';
import 'package:gulfgoal/config/colors.dart';
import 'package:gulfgoal/config/provider.dart';
import 'package:gulfgoal/models/comments.dart';
import 'package:gulfgoal/models/news.dart';
import 'package:gulfgoal/screens/nointernetscreen.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';
import 'dart:async';

class Newsdetails extends StatefulWidget {
  final News news;
  final List<News> relatednews;

  Newsdetails({Key key, this.news, this.relatednews}) : super(key: key);
  @override
  _NewsdetailsState createState() => _NewsdetailsState();
}

class _NewsdetailsState extends State<Newsdetails> {
  share(BuildContext context, String link) {
    final RenderBox box = context.findRenderObject();

    Share.share("${widget.news.title}",
        subject: "${widget.news.title}",
        sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
  }

  List<News> firstfive() {
    List<News> first = List<News>();
    for (var i in widget.relatednews) {
      if (i != null) {
        if (i.title != widget.news.title) {
          first.add(i);
        }
      }
    }
    return first;
  }

  @override
  Widget build(BuildContext context) {
    return ConnectivityWidgetWrapper(
      offlineWidget: Nointernetscreen(),
      child: Scaffold(
        body: SafeArea(
          child: ListView(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.arrow_back,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
              Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                            right: 20,
                          ),
                          child: Tittletext(
                            data: widget.news.title,
                            size: 16,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // CircleAvatar(
                          //   backgroundColor: Colors.grey,
                          //   radius: 20,
                          //   backgroundImage: AssetImage(
                          //     "asset/nopic.jpg",
                          //   ),
                          // ),
                          Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Normaltext(
                                    string: widget.news.tag,
                                    color: Colors.grey.shade900,
                                    fontWeight: FontWeight.w600,
                                    fontsize: 10,
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Normaltext(
                                      string: widget.news.time,
                                      color: Colors.grey.shade400,
                                      fontsize: 10,
                                      fontWeight: FontWeight.normal),
                                ],
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 0),
                            child: IconButton(
                              onPressed: () {
                                share(context, "link");
                              },
                              icon: Icon(FontAwesomeIcons.share),
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.end,
                    //   children: [

                    //   ],
                    // ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                  constraints: new BoxConstraints.expand(
                    height: 212,
                  ),
                  alignment: Alignment.topRight,
                  padding:
                      new EdgeInsets.symmetric(horizontal: 34, vertical: 13),
                  decoration: new BoxDecoration(
                    image: new DecorationImage(
                      image: new NetworkImageWithRetry(
                        widget.news.image,
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: GestureDetector(
                    child: Container(
                      width: 34,
                      height: 34,
                      decoration: new BoxDecoration(
                        color: Color(0xff000000).withOpacity(.6),
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Icon(
                          FontAwesomeIcons.solidHeart,
                          color: Color(0xffFCFCFC),
                          size: 17,
                        ),
                      ),
                    ),
                  )),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Contenttext(data: widget.news.content, size: 12),
              ),
              SizedBox(
                height: 20,
              ),
              Sendcomment(
                newsid: widget.news.id,
              ),
              Commentstream(
                id: widget.news.id,
              ),
              SizedBox(
                height: 23,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Boldaccectcolor(
                  size: 16,
                  text: "Related News",
                ),
              ),
              Latestnewslist(news: firstfive(), ishomescreen: true)
            ],
          ),
        ),
      ),
    );
  }
}
