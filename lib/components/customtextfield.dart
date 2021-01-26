import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:gulfgoal/config/colors.dart';
import 'package:gulfgoal/config/provider.dart';
import 'package:gulfgoal/locale/locales.dart';
import 'package:provider/provider.dart';

class CustomTextfield extends StatelessWidget {
  final String hint, label;
  final Widget suffix;
  final IconData priffix;
  final TextEditingController controller;
  final bool isobscure, borderd;
  final int validator;
  final Function customvalidator;

  CustomTextfield(
      {Key key,
      this.hint,
      this.label,
      this.priffix = null,
      this.suffix = null,
      this.controller,
      this.isobscure = false,
      this.validator = null,
      this.customvalidator = null,
      this.borderd = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<MultiValidator> validators = [
      MultiValidator([
        RequiredValidator(
            errorText: AppLocalizations.of(context).thisfieldisrequired),
      ]),
      MultiValidator([
        RequiredValidator(
            errorText: AppLocalizations.of(context).thisfieldisrequired),
        EmailValidator(errorText: AppLocalizations.of(context).emailisnotvalid)
      ]),
      MultiValidator([
        RequiredValidator(
            errorText: AppLocalizations.of(context).thisfieldisrequired),
        MinLengthValidator(8, errorText: ''),
        PatternValidator(r'(?=.*?[#?!@$%^&*-])',
            errorText: AppLocalizations.of(context).mailnotvalid),
      ]),
    ];
    return TextFormField(
        controller: controller,
        obscureText: isobscure,
        decoration: new InputDecoration(
            focusedBorder: borderd == true
                ? OutlineInputBorder(
                    borderSide: new BorderSide(color: accentcolor))
                : null,
            border: borderd == true
                ? OutlineInputBorder(
                    borderSide: new BorderSide(color: accentcolor))
                : null,
            hintText: hint,
            labelText: label,
            labelStyle: TextStyle(
              color: textcolor,
              fontFamily: Provider.of<Userprovider>(context, listen: false)
                  .font(context),
            ),
            prefixIcon: Icon(
              priffix,
              color: accentcolor,
            ),
            prefixText: ' ',
            suffix: suffix,
            suffixStyle: TextStyle(
              color: accentcolor,
              fontFamily: Provider.of<Userprovider>(context, listen: false)
                  .font(context),
            )),
        validator: validators[validator]);
  }
}
