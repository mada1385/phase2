import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gulfgoal/components/texts.dart';
import 'package:gulfgoal/config/colors.dart';
import 'package:gulfgoal/models/news.dart';

class Newscarddetails extends StatelessWidget {
  Newscarddetails({
    Key key,
    @required this.news,
    this.backcolor = accentcolor,
    this.fontcolor = Colors.white,
    this.padding = 8.0,
  }) : super(key: key);

  final News news;
  final Color backcolor, fontcolor;
  final double padding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(padding),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: 18,
            decoration: new BoxDecoration(
                color: backcolor.withOpacity(.5),
                // shape: BoxShape.circle,
                borderRadius: BorderRadius.all(Radius.circular(10))),
            child: Center(
              child: Row(
                children: [
                  Normaltext(
                      color: fontcolor,
                      padding: 10,
                      string: news.tag.length < 15
                          ? news.tag
                          : news.tag.substring(10) + '...',
                      fontsize: 10),
                  // Icon(
                  //   FontAwesomeIcons.solidHeart,
                  //   color: Color(0xffFCFCFC),
                  //   size: 17,
                  // ),
                ],
              ),
            ),
          ),
          Row(
            children: [
              Container(
                height: 18,
                decoration: new BoxDecoration(
                    color: backcolor.withOpacity(.5),
                    // shape: BoxShape.circle,
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Center(
                    child: Row(
                      children: [
                        Normaltext(
                            color: fontcolor,
                            padding: 5,
                            string: news.likedby.length.toString() == null
                                ? 0
                                : news.likedby.length.toString(),
                            fontsize: 10),
                        Icon(
                          FontAwesomeIcons.solidHeart,
                          color: fontcolor,
                          size: 14,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Container(
                height: 18,
                decoration: new BoxDecoration(
                    color: backcolor.withOpacity(.5),
                    // shape: BoxShape.circle,
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Center(
                    child: Row(
                      children: [
                        Normaltext(
                            color: fontcolor,
                            padding: 5,
                            string: news.commets.length.toString() == null
                                ? 0
                                : news.commets.length.toString(),
                            fontsize: 10),
                        Icon(
                          FontAwesomeIcons.solidCommentAlt,
                          color: fontcolor,
                          size: 13,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
