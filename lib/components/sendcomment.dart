import 'package:flutter/material.dart';
import 'package:flutter_image/network.dart';
import 'package:gulfgoal/config/colors.dart';
import 'package:gulfgoal/components/commenttextfield.dart';
import 'package:gulfgoal/config/provider.dart';
import 'package:gulfgoal/locale/locales.dart';
import 'package:gulfgoal/services/commentsAPI.dart';
import 'package:provider/provider.dart';

class Sendcomment extends StatefulWidget {
  Sendcomment({
    Key key,
    this.padding = 28,
    @required this.newsid,
    this.match = false,
  }) : super(key: key);

  final String newsid;
  final bool match;

  final double padding;

  @override
  _SendcommentState createState() => _SendcommentState();
}

class _SendcommentState extends State<Sendcomment> {
  final commentcontroller = TextEditingController();

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
          padding: EdgeInsets.symmetric(horizontal: widget.padding),
          child: Row(
            children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundImage:
                        Provider.of<Userprovider>(context).image != null
                            ? NetworkImageWithRetry(
                                Provider.of<Userprovider>(context).image)
                            : AssetImage("asset/nopic.jpg"),
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
                          hint: AppLocalizations.of(context).addacomment,
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
                  onPressed: () async {
                    if (Provider.of<Userprovider>(context, listen: false)
                            .token !=
                        null) {
                      if (widget.match == false) {
                        await CommentApi()
                            .postcomment(
                                commentcontroller.text,
                                Provider.of<Userprovider>(context,
                                        listen: false)
                                    .token,
                                widget.newsid)
                            .then((value) => Provider.of<Userprovider>(context,
                                    listen: false)
                                .loadcomments(widget.newsid));
                      } else {
                        await CommentApi()
                            .postmatchcomment(
                                commentcontroller.text,
                                Provider.of<Userprovider>(context,
                                        listen: false)
                                    .token,
                                widget.newsid)
                            .then((value) => Provider.of<Userprovider>(context,
                                    listen: false)
                                .loadmatchcomments(widget.newsid));
                      }
                      commentcontroller.clear();
                      FocusScope.of(context).unfocus();
                    } else {
                      Scaffold.of(context).showSnackBar(SnackBar(
                          duration: Duration(seconds: 1),
                          elevation: 10,
                          padding: EdgeInsets.symmetric(vertical: 10),
                          backgroundColor: accentcolor,
                          content: Container(
                              child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Text(
                              "You must register to comment",
                              style: TextStyle(
                                  fontFamily: Provider.of<Userprovider>(context,
                                          listen: false)
                                      .font(context),
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600),
                            ),
                          ))));
                    }
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
