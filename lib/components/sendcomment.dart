import 'package:flutter/material.dart';
import 'package:gulfgoal/config/colors.dart';
import 'package:gulfgoal/components/commenttextfield.dart';
import 'package:gulfgoal/config/provider.dart';
import 'package:gulfgoal/services/comments.dart';
import 'package:provider/provider.dart';

class Sendcomment extends StatelessWidget {
  Sendcomment({
    Key key,
    this.padding = 28,
    @required this.newsid,
  }) : super(key: key);

  final commentcontroller = TextEditingController();

  final String newsid;

  final double padding;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 304,
          height: 1,
          color: Color(0xffEEEEEE),
        ),
        SizedBox(
          height: 15,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: padding),
          child: Row(
            children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundColor: textcolor,
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        height: 41,
                        width: 140,
                        child: CommentCustomTextfield(
                          controller: commentcontroller,
                          validator: 0,
                          hint: " add a comment",
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
                    size: 30,
                    color: accentcolor,
                  ),
                  onPressed: () {
                    CommentApi()
                        .postcomment(
                            commentcontroller.text,
                            Provider.of<Userprovider>(context, listen: false)
                                .token,
                            newsid)
                        .then((value) =>
                            Provider.of<Userprovider>(context, listen: false)
                                .loadcomments(newsid));
                  })
            ],
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
          ),
        ),
        SizedBox(
          height: 15,
        ),
        Container(
          width: 304,
          height: 1,
          color: Color(0xffEEEEEE),
        ),
      ],
    );
  }
}
