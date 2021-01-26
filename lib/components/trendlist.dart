import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gulfgoal/components/trendnewscard.dart';
import 'package:gulfgoal/config/colors.dart';
import 'package:gulfgoal/config/mediaqueryconfig.dart';
import 'package:gulfgoal/config/provider.dart';
import 'package:gulfgoal/models/news.dart';
import 'package:gulfgoal/screens/newsdetails.dart';
import 'package:provider/provider.dart';

class Trendlist extends StatefulWidget {
  const Trendlist({
    Key key,
    @required this.news,
    @required this.ishomescreen,
  }) : super(key: key);

  final List<News> news;
  final bool ishomescreen;

  @override
  _TrendlistState createState() => _TrendlistState();
}

class _TrendlistState extends State<Trendlist> {
  List<News> sorteddata() {
    List<News> sortednews;
    if (!widget.ishomescreen) {
      print(widget.news);
      if (Provider.of<Userprovider>(context).initvaluetrends ==
          "All categories") {
        setState(() {
          print("notsorted");
          sortednews = widget.news;
        });
      } else {
        setState(() {
          print(Provider.of<Userprovider>(context).initvaluetrends);
          sortednews = widget.news
              .where((i) =>
                  i.tag == Provider.of<Userprovider>(context).initvaluetrends)
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
    sortednews = Provider.of<Userprovider>(context, listen: false)
        .allnews
        .where((i) => i.tag == x.tag)
        .toList();
    return sortednews;
  }

  List<Widget> getunderline() {
    List<Widget> w = [];
    for (int i = 0; i < sorteddata().length; i++) {
      w.add(
        Container(
          margin: EdgeInsets.all(8.0),
          height: 10,
          width: 10,
          decoration: BoxDecoration(
              // shape: BoxShape.circle,
              border: Border.all(
                  color: pageIndex != i ? accentcolor : Colors.white),
              borderRadius: BorderRadius.all(Radius.circular(5)),
              color: pageIndex == i ? accentcolor : Colors.white),
        ),
      );
    }
    return w;
  }

  PageController controller = PageController();
  int pageIndex = 0;
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<Userprovider>(context, listen: false)
          .setalltrends(widget.news);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Column(
      children: [
        Container(
          height: 250,
          width: MediaQuery.of(context).size.width,
          child: PageView(
            onPageChanged: (value) {
              HapticFeedback.lightImpact();
              setState(() {
                pageIndex = value;
              });
            },
            controller: controller,
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
                    child: TrendNewscard(
                      news: i,
                    ),
                  );
                },
              );
            }).toList(),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: getunderline(),
        ),
      ],
    );
  }
}
