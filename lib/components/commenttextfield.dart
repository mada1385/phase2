import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:gulfgoal/config/colors.dart';
import 'package:gulfgoal/config/provider.dart';
import 'package:provider/provider.dart';

class CommentCustomTextfield extends StatelessWidget {
  final String hint;
  final TextEditingController controller;
  final bool autofoucs;
  final int validator;

  CommentCustomTextfield({
    this.autofoucs = false,
    Key key,
    this.hint,
    this.controller,
    this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        autofocus: autofoucs,
        controller: controller,
        decoration: new InputDecoration(
            border: InputBorder.none,
            hintText: hint,
            labelStyle: TextStyle(
              color: textcolor,
              fontFamily: Provider.of<Userprovider>(context, listen: false)
                  .font(context),
            ),
            prefixText: ' ',
            suffixStyle: TextStyle(
              color: accentcolor,
              fontFamily: Provider.of<Userprovider>(context, listen: false)
                  .font(context),
            )),
        validator: RequiredValidator(errorText: 'the comment cant be empty'));
  }
}
