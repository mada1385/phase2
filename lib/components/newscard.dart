import 'package:flutter/material.dart';
import 'package:flutter_image/network.dart';
import 'package:gulfgoal/components/texts.dart';
import 'package:gulfgoal/components/newscarddetails.dart';

import 'package:gulfgoal/config/mediaqueryconfig.dart';
import 'package:gulfgoal/models/news.dart';

class Newscard extends StatelessWidget {
  final News news;

  const Newscard({Key key, this.news}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Container(
          height: 120,
          width: double.infinity,
          margin: EdgeInsets.symmetric(horizontal: 5.0),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(8.0)),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  blurRadius: 2,
                  color: Colors.black12,
                  offset: Offset(0, .75),
                )
              ]),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ClipRRect(
                    borderRadius: BorderRadius.all(
                      Radius.circular(8.0),
                    ),
                    child: new Image(
                      image: new NetworkImageWithRetry(
                        news.image,
                      ),
                      fit: BoxFit.cover,
                      height: 79,
                      width: 137,
                    )),
                SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width / 1.85,
                      child: Cardtitle(
                        news: news.title,
                        fontsize: 14,
                      ),
                    ),
                    Newscarddetails(
                      padding: 0,
                      news: news,
                      backcolor: Colors.white,
                      fontcolor: Color(0xffA5A5A5),
                    )
                  ],
                )
              ],
            ),
          )),
    );
  }
}
