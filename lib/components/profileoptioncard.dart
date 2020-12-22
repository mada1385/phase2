import 'package:flutter/material.dart';
import 'package:gulfgoal/components/texts.dart';

class Profileoptioncard extends StatelessWidget {
  final String title;
  final Widget icon;
  final Function ontap;
  Profileoptioncard({Key key, this.title, this.icon, this.ontap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: GestureDetector(
          onTap: ontap,
          child: Card(
            elevation: 20,
            child: ListTile(
              // title: Text(date),
              // leading: icon,
              title: Normaltext(
                string: title,
                color: Colors.black,
                fontsize: 14,
                fontWeight: FontWeight.w500,
              ),
              trailing: icon == null ? Icon(Icons.chevron_right) : icon,
              // isThreeLine: true,
            ),
          )),
    );
  }
}
