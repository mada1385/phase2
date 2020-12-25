import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Addtask extends StatelessWidget {
//  final Function addtask ;
  String task;
//   Addtask(this.addtask);
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xff757575),
      child: Padding(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Container(
          height: 200,
          padding: EdgeInsets.symmetric(horizontal: 30.0),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30.0),
                  topRight: Radius.circular(30.0))),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 20.0,
              ),
              Text(
                "Add task!",
                style: TextStyle(color: Colors.lightBlue, fontSize: 30),
              ),
              TextField(
                onChanged: (value) {
                  task = value;
                  print(value);
                },
                // autofocus: true,
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  hintText: "enter your task",
                ),
              ),
              SizedBox(
                height: 20,
              ),
              FlatButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  "done",
                  textAlign: TextAlign.center,
                ),
                color: Colors.lightBlue,
                shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(18.0),
                    side: BorderSide(color: Colors.white)),
              )
            ],
          ),
        ),
      ),
    );
  }
}
