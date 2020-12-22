import 'package:flutter/material.dart';
import 'package:gulfgoal/components/texts.dart';
import 'package:gulfgoal/config/colors.dart';
import 'package:gulfgoal/config/mediaqueryconfig.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class Statrow extends StatelessWidget {
  const Statrow({
    Key key,
    @required this.match,
  }) : super(key: key);

  final dynamic match;

  double indicator() {
    double percent =
        int.parse(match["home"].replaceAll(RegExp('%'), '')).toDouble() /
            (int.parse(match["home"].replaceAll(RegExp('%'), '')).toDouble() +
                    int.parse(match["away"].replaceAll(RegExp('%'), '')))
                .toDouble();
    return percent;
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: MediaQuery.of(context).size.width - 100,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Normaltext(
                    string: match["home"],
                    fontWeight: FontWeight.bold,
                    color: accentcolor,
                    fontsize: 14,
                  ),
                  Normaltext(
                    string: match["type"],
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                    fontsize: 14,
                  ),
                  Normaltext(
                    string: match["away"],
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                    fontsize: 14,
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.all(10),
                  child: new LinearPercentIndicator(
                    width: MediaQuery.of(context).size.width - 100,
                    animation: true,
                    lineHeight: 10.0,
                    animationDuration: 2500,
                    percent: indicator(),

                    // center: Text("80.0%"),
                    linearStrokeCap: LinearStrokeCap.roundAll,
                    progressColor: accentcolor,
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
