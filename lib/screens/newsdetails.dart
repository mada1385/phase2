import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_image/network.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gulfgoal/components/commentstream.dart';
import 'package:gulfgoal/components/sendcomment.dart';
import 'package:gulfgoal/components/relatednewslist.dart';
import 'package:gulfgoal/components/texts.dart';
import 'package:gulfgoal/config/colors.dart';
import 'package:gulfgoal/config/provider.dart';
import 'package:gulfgoal/locale/locales.dart';
import 'package:gulfgoal/models/news.dart';
import 'package:gulfgoal/services/newsAPI.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';

class Newsdetails extends StatefulWidget {
  final News news;
  final List<News> relatednews;
  final News previosnews;

  Newsdetails({Key key, this.news, this.relatednews, this.previosnews = null})
      : super(key: key);
  @override
  _NewsdetailsState createState() => _NewsdetailsState();
}

class _NewsdetailsState extends State<Newsdetails> {
  bool liked = false;
  int likes;

  share(BuildContext context, String link) {
    final RenderBox box = context.findRenderObject();

    Share.share("${widget.news.title}",
        subject: "${widget.news.title}",
        sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
  }

  List<News> firstfive() {
    List<News> first = [];
    int counter = 0;
    for (var i in widget.relatednews) {
      if (counter == 5) {
        break;
      } else {
        if (i.id != widget.news.id) {
          first.add(i);
          counter++;
        }
      }
    }
    return first;
  }

  Timer _clockTimer;

  // void isstrem() {
  //   print("from comment newsdetails");
  //   setState(() {
  //     if (Provider.of<Userprovider>(context, listen: false).token != null) {
  //       Provider.of<Userprovider>(context, listen: false)
  //           .loadcomments(widget.news.id);
  //     }
  //   });
  // }

  @override
  void initState() {
    if (widget.previosnews != null) {
      print(widget.previosnews.id);
    }
    print(widget.news.id);

    setState(() {
      liked = Provider.of<Userprovider>(context, listen: false)
          .isliked(widget.news.likedby);
    });
    // Provider.of<Userprovider>(context, listen: false)
    //     .loadcomments(widget.news.id);
    // _clockTimer = Timer.periodic(Duration(seconds: 20), (_) => isstrem());
    super.initState();
  }

  void dispose() {
    print("killed");
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (widget.previosnews != null) {
          await Provider.of<Userprovider>(context, listen: false)
              .killfavstream();
          await Provider.of<Userprovider>(context, listen: false)
              .loadcomments(widget.previosnews.id);
        }

        Navigator.pop(context);
      },
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              Container(
                color: Color(0xffF2FBF9),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 30,
                        width: 20,
                        child: IconButton(
                          icon: Icon(
                            Icons.arrow_back,
                            color: accentcolor,
                          ),
                          onPressed: () async {
                            if (widget.previosnews != null) {
                              await Provider.of<Userprovider>(context,
                                      listen: false)
                                  .killfavstream();
                              await Provider.of<Userprovider>(context,
                                      listen: false)
                                  .loadcomments(widget.previosnews.id);
                            }

                            Navigator.pop(context);
                          },
                        ),
                      ),
                      Expanded(
                        child: Center(
                          child: Image.asset(
                            "asset/ Gulf Goal Logo.png",
                            height: 30,
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: ListView(
                  physics: BouncingScrollPhysics(),
                  children: [
                    Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width,
                            child: Padding(
                              padding: const EdgeInsetsDirectional.only(
                                  start: 20, end: 20),
                              child: Tittletext(
                                data: widget.news.title,
                                size: 18,
                              ),
                            ),
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Normaltext(
                                          padding: 0,
                                          string: widget.news.tag,
                                          color: Colors.grey.shade900,
                                          fontWeight: FontWeight.w600,
                                          fontsize: 10,
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Normaltext(
                                            padding: 0,
                                            string: widget.news.time,
                                            color: Colors.grey.shade400,
                                            fontsize: 10,
                                            fontWeight: FontWeight.normal),
                                      ],
                                    ),
                                  ],
                                ),
                                Row(
                                  // crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            height: 18,
                                            decoration: new BoxDecoration(
                                                // shape: BoxShape.circle,
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10))),
                                            child: Center(
                                              child: Row(
                                                children: [
                                                  Normaltext(
                                                      color: Color(0xffA5A5A5),
                                                      padding: 5,
                                                      string: widget
                                                          .news.likedby.length
                                                          .toString(),
                                                      fontsize: 10),
                                                  Icon(
                                                    FontAwesomeIcons.solidHeart,
                                                    color: Color(0xffA5A5A5),
                                                    size: 17,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Container(
                                            height: 18,
                                            decoration: new BoxDecoration(
                                                // shape: BoxShape.circle,
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10))),
                                            child: Center(
                                              child: Row(
                                                children: [
                                                  Normaltext(
                                                      color: Color(0xffA5A5A5),
                                                      padding: 5,
                                                      string: widget
                                                          .news.commets.length
                                                          .toString(),
                                                      fontsize: 10),
                                                  Icon(
                                                    FontAwesomeIcons
                                                        .solidCommentAlt,
                                                    color: Color(0xffA5A5A5),
                                                    size: 17,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 0),
                                      child: IconButton(
                                        onPressed: () {
                                          share(context, "link");
                                        },
                                        icon: Icon(FontAwesomeIcons.share),
                                      ),
                                    ),
                                  ],
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
                        padding: new EdgeInsets.symmetric(
                            horizontal: 34, vertical: 13),
                        decoration: new BoxDecoration(
                          image: new DecorationImage(
                            image: new NetworkImageWithRetry(
                              widget.news.image,
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: GestureDetector(
                          onTap: () {
                            if (Provider.of<Userprovider>(context,
                                        listen: false)
                                    .token !=
                                null) {
                              HapticFeedback.mediumImpact();
                              NewsAPI().likenews(
                                  Provider.of<Userprovider>(context,
                                          listen: false)
                                      .token,
                                  widget.news.id);
                              setState(() {
                                liked = !liked;
                              });
                            } else {
                              HapticFeedback.mediumImpact();
                              Future.delayed(Duration(milliseconds: 30), () {
                                // 5s over, navigate to a new page
                                HapticFeedback.mediumImpact();
                              });
                              Scaffold.of(context).showSnackBar(SnackBar(
                                  duration: Duration(seconds: 1),
                                  elevation: 10,
                                  padding: EdgeInsets.symmetric(vertical: 10),
                                  backgroundColor: accentcolor,
                                  content: Container(
                                      child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    child: Text(
                                      AppLocalizations.of(context)
                                          .youmustregister,
                                      style: TextStyle(
                                          fontFamily: Provider.of<Userprovider>(
                                                  context,
                                                  listen: false)
                                              .font(context),
                                          color: Colors.white,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ))));
                            }
                          },
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
                                color: liked == false
                                    ? Color(0xffFCFCFC)
                                    : accentcolor,
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
                      child: Normaltext(
                        string: widget.news.content,
                        fontsize: 15,
                        color: Color(0xff616161),
                        padding: 0,
                      ),
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
                        text: AppLocalizations.of(context).relatedNews,
                      ),
                    ),
                    Relatednews(
                      news: firstfive(),
                      previosnews: widget.news,
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
