import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gulfgoal/components/sendreply.dart';
import 'package:gulfgoal/components/texts.dart';
import 'package:gulfgoal/config/colors.dart';
import 'package:gulfgoal/models/comments.dart';

class Commentmodel extends StatelessWidget {
  const Commentmodel({
    Key key,
    @required this.newsid,
    this.comments,
  }) : super(key: key);

  final String newsid;
  final List<Comment> comments;

  @override
  Widget build(BuildContext context) {
    return Column(
        children: comments.map((i) {
      return Builder(
        builder: (BuildContext context) {
          return Commentelemnt(
            comment: i,
            newsid: newsid,
          );
        },
      );
    }).toList());
  }
}

class Commentelemnt extends StatelessWidget {
  const Commentelemnt({
    Key key,
    @required this.comment,
    @required this.newsid,
  }) : super(key: key);

  final Comment comment;
  final String newsid;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 28),
      child: Column(
        children: [
          SizedBox(
            height: 13,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                backgroundColor: textcolor,
              ),
              SizedBox(
                width: 15,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Boldaccectcolor(
                    text: comment.name,
                    size: 14,
                  ),
                  Container(
                    width: 216,
                    child: Contenttext(data: comment.content, size: 12),
                  ),
                  SizedBox(
                    height: 13,
                  ),
                  Row(
                    children: [
                      GestureDetector(
                        child: Icon(
                          FontAwesomeIcons.solidHeart,
                          size: 25,
                          color: accentcolor,
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Normalaccecttext(
                        text: "34",
                        size: 12,
                      ),
                      SizedBox(
                        width: 21,
                      ),
                      GestureDetector(
                        onTap: () {
                          showModalBottomSheet(
                            context: context,
                            builder: (context) => Sendreply(
                              commentid: comment.commentid,
                              newsid: newsid,
                            ),
                            isScrollControlled: true,
                          );
                        },
                        child: Icon(
                          FontAwesomeIcons.reply,
                          size: 25,
                          color: accentcolor,
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Normalaccecttext(
                        text: "1",
                        size: 12,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 17,
                  ),
                  // Sendreply(
                  //   newsid: newsid,
                  //   commentid: comment.id,
                  //   padding: 0,
                  // ),
                  Column(
                    children: comment.replyes.map((i) {
                      return Builder(
                        builder: (BuildContext context) {
                          return Container(
                            decoration: BoxDecoration(
                                border: Border(
                                    left: BorderSide(
                                        color: accentcolor, width: 2))),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: 13,
                                ),
                                CircleAvatar(
                                  backgroundColor: textcolor,
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Boldaccectcolor(
                                      text: "John Doe",
                                      size: 14,
                                    ),
                                    Container(
                                      width: 200,
                                      child: Contenttext(
                                          data:
                                              "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy",
                                          size: 12),
                                    ),
                                    SizedBox(
                                      height: 13,
                                    ),
                                  ],
                                )
                              ],
                            ),
                          );
                        },
                      );
                    }).toList(),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(
            height: 13,
          ),
          Container(
            width: 304,
            height: 1,
            color: Color(0xffEEEEEE),
          ),
        ],
      ),
    );
  }
}
