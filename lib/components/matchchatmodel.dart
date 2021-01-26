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

class Matchchatmodel extends StatelessWidget {
  const Matchchatmodel({
    Key key,
    this.matchid,
    this.comments,
  }) : super(key: key);
  final String matchid;
  final List<Comment> comments;
  @override
  Widget build(BuildContext context) {
    return Column(
        children: comments.map((i) {
      return Builder(
        builder: (BuildContext context) {
          return Matchcommentelement(
            matchid: matchid,
            comment: i,
          );
        },
      );
    }).toList());
  }
}

class Matchcommentelement extends StatefulWidget {
  Matchcommentelement({
    Key key,
    @required this.matchid,
    @required this.comment,
  }) : super(key: key);

  final String matchid;
  final Comment comment;

  @override
  _MatchcommentelementState createState() => _MatchcommentelementState();
}

class _MatchcommentelementState extends State<Matchcommentelement> {
  bool liked = false;
  @override
  void initState() {
    setState(() {
      liked = Provider.of<Userprovider>(context, listen: false)
          .isliked(widget.comment.likedby);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.only(
        start: 20,
      ),
      child: Container(
        child: Column(
          children: [
            SizedBox(
              height: 13,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  backgroundImage: widget.comment.image != null
                      ? NetworkImageWithRetry(widget.comment.image)
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
                      text: widget.comment.name,
                      size: 14,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width - 130,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width - 160,
                                child: Contenttext(
                                    data: widget.comment.content, size: 12),
                              ),
                              GestureDetector(
                                onTap: () async {
                                  if (Provider.of<Userprovider>(context,
                                              listen: false)
                                          .token !=
                                      null) {
                                    HapticFeedback.mediumImpact();
                                    await CommentApi()
                                        .likematchcomment(
                                            widget.comment.id,
                                            Provider.of<Userprovider>(context,
                                                    listen: false)
                                                .token,
                                            widget.matchid)
                                        .then((value) {
                                      setState(() {
                                        Provider.of<Userprovider>(context,
                                                listen: false)
                                            .loadmatchcomments(widget.matchid);
                                        liked = !liked;
                                      });
                                    });
                                  } else {
                                    HapticFeedback.mediumImpact();
                                    Future.delayed(Duration(milliseconds: 30),
                                        () {
                                      // 5s over, navigate to a new page
                                      HapticFeedback.mediumImpact();
                                    });
                                    Scaffold.of(context).showSnackBar(SnackBar(
                                        duration: Duration(seconds: 1),
                                        elevation: 10,
                                        padding:
                                            EdgeInsets.symmetric(vertical: 10),
                                        backgroundColor: accentcolor,
                                        content: Container(
                                            child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10),
                                          child: Text(
                                            AppLocalizations.of(context)
                                                .youmustregister,
                                            style: TextStyle(
                                                fontFamily:
                                                    Provider.of<Userprovider>(
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
                                child: liked == false
                                    ? Icon(
                                        FontAwesomeIcons.heart,
                                        size: 16,
                                      )
                                    : Icon(
                                        FontAwesomeIcons.solidHeart,
                                        color: accentcolor,
                                        size: 16,
                                      ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Normaltext(
                              padding: 0,
                              string: widget.comment.time,
                              fontsize: 10,
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Normaltext(
                              padding: 0,
                              string:
                                  "${widget.comment.likedby.length} ${AppLocalizations.of(context).likes}",
                              fontsize: 12,
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            GestureDetector(
                              onTap: () {
                                if (Provider.of<Userprovider>(context,
                                            listen: false)
                                        .token !=
                                    null) {
                                  HapticFeedback.mediumImpact();
                                  showModalBottomSheet(
                                    context: context,
                                    builder: (context) => Sendreply(
                                        match: true,
                                        commentid: widget.comment.id,
                                        newsid: widget.matchid),
                                    isScrollControlled: true,
                                  );
                                } else {
                                  HapticFeedback.mediumImpact();
                                  Future.delayed(Duration(milliseconds: 30),
                                      () {
                                    // 5s over, navigate to a new page
                                    HapticFeedback.mediumImpact();
                                  });
                                  Scaffold.of(context).showSnackBar(SnackBar(
                                      duration: Duration(seconds: 1),
                                      elevation: 10,
                                      padding:
                                          EdgeInsets.symmetric(vertical: 10),
                                      backgroundColor: accentcolor,
                                      content: Container(
                                          child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10),
                                        child: Text(
                                          AppLocalizations.of(context)
                                              .youmustregister,
                                          style: TextStyle(
                                              fontFamily:
                                                  Provider.of<Userprovider>(
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
                              child: Normaltext(
                                padding: 0,
                                string: AppLocalizations.of(context).reply,
                                fontsize: 12,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Column(
                          children: widget.comment.replyes.map((i) {
                            return Builder(
                              builder: (BuildContext context) {
                                return Padding(
                                  padding: const EdgeInsets.only(top: 5),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        border: Border(
                                            left: BorderSide(
                                                color: accentcolor, width: 2))),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width -
                                                  200,
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
                    // SizedBox(
                    //   height: 13,
                    // ),
                    SizedBox(
                      height: 17,
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
