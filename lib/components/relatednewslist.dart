import 'package:flutter/material.dart';
import 'package:gulfgoal/components/newscard.dart';
import 'package:gulfgoal/config/provider.dart';
import 'package:gulfgoal/models/news.dart';
import 'package:gulfgoal/screens/newsdetails.dart';
import 'package:provider/provider.dart';

class Relatednews extends StatefulWidget {
  const Relatednews({
    Key key,
    @required this.news,
    this.previosnews,
  }) : super(key: key);

  final List<News> news;
  final News previosnews;

  @override
  _RelatednewsState createState() => _RelatednewsState();
}

class _RelatednewsState extends State<Relatednews> {
  List<News> sorteddata() {
    List<News> sortednews;

    setState(() {
      print("notsorted");
      sortednews = widget.news;
    });

    return sortednews;
  }

  List<News> relateddata(News x) {
    List<News> sortednews;
    sortednews = widget.news.where((i) => i.tag == x.tag).toList();
    return sortednews;
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<Userprovider>(context, listen: false).setallnews(widget.news);
    });
    super.initState();
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
                        builder: (context) => new Newsdetails(
                              previosnews: widget.previosnews,
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
