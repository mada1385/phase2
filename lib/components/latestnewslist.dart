import 'package:flutter/material.dart';
import 'package:gulfgoal/components/newscard.dart';
import 'package:gulfgoal/config/provider.dart';
import 'package:gulfgoal/models/news.dart';
import 'package:gulfgoal/screens/newsdetails.dart';
import 'package:provider/provider.dart';

class Latestnewslist extends StatefulWidget {
  const Latestnewslist({
    Key key,
    @required this.news,
    @required this.ishomescreen,
  }) : super(key: key);

  final List<News> news;
  final bool ishomescreen;

  @override
  _LatestnewslistState createState() => _LatestnewslistState();
}

class _LatestnewslistState extends State<Latestnewslist> {
  List<News> sorteddata() {
    List<News> sortednews;
    if (!widget.ishomescreen) {
      print(widget.news);
      if (Provider.of<Userprovider>(context).initvaluenews ==
          "All categories") {
        setState(() {
          print("notsorted");
          sortednews = widget.news;
        });
      } else {
        setState(() {
          print(Provider.of<Userprovider>(context).initvaluenews);
          sortednews = Provider.of<Userprovider>(context, listen: false)
              .allnews
              .where((i) =>
                  i.tag == Provider.of<Userprovider>(context).initvaluenews)
              .toList();
        });
      }
      return sortednews;
    } else {
      setState(() {
        print("notsorted");
        sortednews = widget.news;
      });
      return sortednews;
    }
  }

  List<News> relateddata(News x) {
    List<News> sortednews;
    sortednews = widget.news.where((i) => i.tag == x.tag).toList();
    return sortednews;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: sorteddata().map((i) {
        return Builder(
          builder: (BuildContext context) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Newsdetails(
                              news: i,
                              relatednews: relateddata(i),
                            )));
              },
              child: Newscard(
                news: i,
              ),
            );
          },
        );
      }).toList(),
    );
  }
}
