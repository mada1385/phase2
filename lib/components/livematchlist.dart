import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:gulfgoal/components/matchtile.dart';
import 'package:gulfgoal/config/provider.dart';
import 'package:gulfgoal/models/match.dart';
import 'package:gulfgoal/screens/matchdetailsscreen.dart';
import 'package:provider/provider.dart';

class Livematchesscoreboard extends StatelessWidget {
  const Livematchesscoreboard({
    Key key,
    this.livematches,
  }) : super(key: key);
  final List<SoccerMatch> livematches;
  @override
  Widget build(BuildContext context) {
    Provider.of<Userprovider>(context, listen: false)
        .setmatchdetails(livematches);
    return CarouselSlider(
      options: CarouselOptions(
          enableInfiniteScroll: false,
          scrollDirection: Axis.horizontal,
          height: 120,
          autoPlay: true,
          autoPlayAnimationDuration: Duration(seconds: 30)),
      items: livematches.map((i) {
        return Builder(
          builder: (BuildContext context) {
            return Padding(
                padding: const EdgeInsets.symmetric(vertical: 15),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MatchDetailsScreen(
                                  x: livematches.indexOf(i),
                                )));
                  },
                  child: Matchtile(
                    match: i,
                  ),
                ));
          },
        );
      }).toList(),
    );
  }
}
