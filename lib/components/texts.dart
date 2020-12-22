import 'package:flutter/material.dart';
import 'package:gulfgoal/config/colors.dart';
import 'package:gulfgoal/config/fonts.dart';
import 'package:gulfgoal/config/mediaqueryconfig.dart';

class Boldaccectcolor extends StatelessWidget {
  final String text;
  final double size;

  const Boldaccectcolor({Key key, this.text, this.size}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Text(
      text,
      style: TextStyle(
          fontFamily: englishfont,
          color: accentcolor,
          fontSize: size == null ? SizeConfig.blockSizeVertical * 3 : size,
          fontWeight: FontWeight.bold),
    );
  }
}

class Normalaccecttext extends StatelessWidget {
  final String text;
  final double size;

  const Normalaccecttext({Key key, this.text, this.size}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Text(
      text,
      style: TextStyle(
          fontFamily: englishfont,
          color: accentcolor,
          fontSize: size == null ? SizeConfig.blockSizeVertical * 3 : size,
          fontWeight: FontWeight.normal),
    );
  }
}

class Contenttext extends StatelessWidget {
  final String data;
  final double size;

  const Contenttext({Key key, @required this.data, @required this.size})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: TextStyle(
        color: textcolor,
        fontSize: size,
        fontWeight: FontWeight.normal,
        fontFamily: englishfont,
      ),
    );
  }
}

class Tittletext extends StatelessWidget {
  final String data;
  final double size;

  const Tittletext({Key key, @required this.data, @required this.size})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: TextStyle(
        color: Colors.black,
        fontSize: size,
        fontWeight: FontWeight.bold,
        fontFamily: englishfont,
      ),
    );
  }
}

class Cardtitle extends StatelessWidget {
  const Cardtitle({
    Key key,
    @required this.news,
    @required this.fontsize,
  }) : super(key: key);

  final String news;
  final double fontsize;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Text(
        news,
        style: TextStyle(
            fontWeight: FontWeight.w500,
            color: textcolor,
            fontFamily: englishfont,
            fontSize: fontsize),
      ),
    );
  }
}

class Normaltext extends StatelessWidget {
  const Normaltext({
    Key key,
    @required this.string,
    @required this.fontsize,
    this.color = Colors.black,
    this.fontWeight = FontWeight.w500,
  }) : super(key: key);

  final String string;
  final double fontsize;
  final Color color;
  final FontWeight fontWeight;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Text(
        string,
        style: TextStyle(
            fontWeight: fontWeight,
            color: color,
            fontFamily: englishfont,
            fontSize: fontsize),
      ),
    );
  }
}

class CenterNormaltext extends StatelessWidget {
  const CenterNormaltext({
    Key key,
    @required this.string,
    @required this.fontsize,
    this.color = Colors.black,
    this.fontWeight = FontWeight.w500,
  }) : super(key: key);

  final String string;
  final double fontsize;
  final Color color;
  final FontWeight fontWeight;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Text(
        string,
        textAlign: TextAlign.center,
        style: TextStyle(
            fontWeight: fontWeight,
            color: color,
            fontFamily: englishfont,
            fontSize: fontsize),
      ),
    );
  }
}
