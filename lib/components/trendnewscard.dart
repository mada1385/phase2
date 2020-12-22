import 'package:flutter/material.dart';
import 'package:flutter_image/network.dart';
import 'package:gulfgoal/components/texts.dart';
import 'package:gulfgoal/config/colors.dart';
import 'package:gulfgoal/config/mediaqueryconfig.dart';
import 'package:gulfgoal/models/news.dart';

class TrendNewscard extends StatelessWidget {
  final News news;

  const TrendNewscard({Key key, this.news}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      child: Container(
          width: 305,
          height: 136,
          margin: EdgeInsets.symmetric(horizontal: 5.0),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(8.0)),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  blurRadius: 2,
                  color: Colors.black54,
                  offset: Offset(0, .75),
                )
              ]),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ClipRRect(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8.0),
                      topRight: Radius.circular(8.0)),
                  child: Image(
                      image: new NetworkImageWithRetry(
                        news.image,
                      ),
                      fit: BoxFit.cover,
                      height: 136,
                      width: double.infinity)),
              SizedBox(
                height: 10,
              ),
              Cardtitle(
                news: news.title,
                fontsize: 16,
              ),
            ],
          )),
    );
  }
}
