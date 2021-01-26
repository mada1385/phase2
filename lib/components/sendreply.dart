import 'package:flutter/material.dart';
import 'package:gulfgoal/config/colors.dart';
import 'package:gulfgoal/components/commenttextfield.dart';
import 'package:gulfgoal/config/provider.dart';
import 'package:gulfgoal/locale/locales.dart';
import 'package:gulfgoal/services/commentsAPI.dart';
import 'package:provider/provider.dart';

class Sendreply extends StatelessWidget {
  final replycontroller = TextEditingController();

  Sendreply({
    Key key,
    // @required this.commentcontroller,
    this.padding = 28,
    @required this.newsid,
    @required this.commentid,
    this.match = false,
  }) : super(key: key);
  final String newsid, commentid;
  final bool match;
  final double padding;

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Color(0xff757575),
        child: Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Container(
              // height: 200,
              padding: EdgeInsets.symmetric(horizontal: 30.0),
              decoration: BoxDecoration(
                color: Colors.white,
                // borderRadius: BorderRadius.only(
                //     topLeft: Radius.circular(30.0),
                //     topRight: Radius.circular(30.0))
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Row(
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                height: 41,
                                width: 140,
                                child: CommentCustomTextfield(
                                  autofoucs: true,
                                  controller: replycontroller,
                                  validator: 0,
                                  hint: AppLocalizations.of(context).addareply,
                                ),
                              ),
                              SizedBox(
                                height: 7.5,
                              ),
                            ],
                          ),
                        ],
                      ),
                      IconButton(
                          icon: Icon(
                            Icons.send,
                            size: 20,
                            color: accentcolor,
                          ),
                          onPressed: () async {
                            if (Provider.of<Userprovider>(context,
                                        listen: false)
                                    .token !=
                                null) {
                              if (match == false) {
                                print("sending news commet");
                                print(replycontroller.text);
                                await CommentApi()
                                    .postreply(
                                        replycontroller.text,
                                        Provider.of<Userprovider>(context,
                                                listen: false)
                                            .token,
                                        newsid,
                                        commentid)
                                    .then((value) => Provider.of<Userprovider>(
                                            context,
                                            listen: false)
                                        .loadcomments(newsid));
                                replycontroller.clear();
                              } else {
                                print("sending match commet");

                                await CommentApi()
                                    .postmatchreply(
                                        replycontroller.text,
                                        Provider.of<Userprovider>(context,
                                                listen: false)
                                            .token,
                                        newsid,
                                        commentid)
                                    .then((value) => Provider.of<Userprovider>(
                                            context,
                                            listen: false)
                                        .loadmatchcomments(newsid));
                              }
                              FocusScope.of(context).unfocus();
                            }
                          })
                    ],
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  ),
                  // SizedBox(
                  //   height: 15,
                  // ),
                  // Container(
                  //   width: 304,
                  //   height: 1,
                  //   color: Color(0xffEEEEEE),
                  // ),
                ],
              ),
            )));
  }
}
