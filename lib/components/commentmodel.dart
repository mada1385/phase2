import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_image/network.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gulfgoal/components/sendreply.dart';
import 'package:gulfgoal/components/texts.dart';
import 'package:gulfgoal/config/colors.dart';
import 'package:gulfgoal/config/provider.dart';
import 'package:gulfgoal/locale/locales.dart';
import 'package:gulfgoal/models/comments.dart';
import 'package:gulfgoal/services/commentsAPI.dart';
import 'package:provider/provider.dart';

class Commentmodel extends StatefulWidget {
  const Commentmodel({
    Key key,
    @required this.newsid,
    this.comments,
  }) : super(key: key);

  final String newsid;
  final List<Comment> comments;

  @override
  _CommentmodelState createState() => _CommentmodelState();
}

class _CommentmodelState extends State<Commentmodel> {
  bool showmore = false;
  List<Comment> showcomments() {
    List<Comment> commennts = List<Comment>();
    int i;
    if (widget.comments.length != 0) {
      if (showmore) {
        for (i = 0; i < widget.comments.length; i++) {
          commennts.add(widget.comments[i]);
        }
      } else {
        for (i = 0; i < 5; i++) {
          if (i < widget.comments.length) {
            commennts.add(widget.comments[i]);
          } else {
            break;
          }
        }
      }
    } else {}
    return commennts;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Column(
            children: showcomments().map((i) {
          return Builder(
            builder: (BuildContext context) {
              return Commentelemnt(
                comment: i,
                newsid: widget.newsid,
              );
            },
          );
        }).toList()),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: widget.comments.length > 5
              ? [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        showmore = !showmore;
                      });
                    },
                    child: Boldaccectcolor(
                      text: showmore ? "Read less " : "Read more ",
                      size: 16,
                    ),
                  )
                ]
              : [],
        )
      ],
    );
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
                backgroundImage: comment.image != null
                    ? NetworkImageWithRetry(comment.image)
                    : AssetImage("asset/nopic.jpg"),
                backgroundColor: textcolor,
              ),
              SizedBox(
                width: 15,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Normalaccecttext(
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
                        onTap: () async {
                          if (Provider.of<Userprovider>(context, listen: false)
                                  .token !=
                              null) {
                            HapticFeedback.mediumImpact();
                            await CommentApi()
                                .likecomment(
                                    comment.id,
                                    Provider.of<Userprovider>(context,
                                            listen: false)
                                        .token,
                                    newsid)
                                .then((value) => Provider.of<Userprovider>(
                                        context,
                                        listen: false)
                                    .loadcomments(newsid));
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
                        child: Icon(
                          FontAwesomeIcons.solidHeart,
                          size: 20,
                          color: accentcolor,
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Normalaccecttext(
                        text: comment.likedby.length.toString(),
                        size: 12,
                      ),
                      SizedBox(
                        width: 21,
                      ),
                      GestureDetector(
                        onTap: () {
                          if (Provider.of<Userprovider>(context, listen: false)
                                  .token !=
                              null) {
                            print(newsid);
                            HapticFeedback.mediumImpact();
                            showModalBottomSheet(
                              context: context,
                              builder: (context) => Sendreply(
                                commentid: comment.commentid,
                                newsid: newsid,
                              ),
                              isScrollControlled: true,
                            );
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
                        child: Icon(
                          FontAwesomeIcons.reply,
                          size: 20,
                          color: accentcolor,
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Normalaccecttext(
                        text: comment.replyes.length.toString(),
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
                          return Padding(
                            padding: const EdgeInsets.only(top: 8),
                            child: Container(
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
                                    backgroundImage: i.image != null
                                        ? NetworkImageWithRetry(i.image)
                                        : AssetImage("asset/nopic.jpg"),
                                    backgroundColor: textcolor,
                                  ),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Normalaccecttext(
                                        text: i.name,
                                        size: 14,
                                      ),
                                      Container(
                                        width: 200,
                                        child: Contenttext(
                                            data: i.content, size: 12),
                                      ),
                                      SizedBox(
                                        height: 13,
                                      ),
                                    ],
                                  )
                                ],
                              ),
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
