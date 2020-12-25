import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:gulfgoal/config/colors.dart';

class CustomTextfield extends StatelessWidget {
  List<MultiValidator> validators = [
    MultiValidator([
      RequiredValidator(errorText: ''),
    ]),
    MultiValidator([
      RequiredValidator(errorText: 'اسم المستخدم مطلوب'),
      EmailValidator(errorText: "هذا البريد غير صالح")
    ]),
    MultiValidator([
      RequiredValidator(errorText: 'كلمة المرور مطلوبة'),
      MinLengthValidator(8,
          errorText: 'يجب أن تتكون كلمة المرور من 8 أرقام على الأقل'),
      PatternValidator(r'(?=.*?[#?!@$%^&*-])',
          errorText: 'يجب تحتوي كلمة المرور على حرف خاص واحد على الاقل'),
    ]),
  ];

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
              fontFamily: 'cairo',
            ),
            prefixIcon: Icon(
              priffix,
              color: accentcolor,
            ),
            prefixText: ' ',
            suffix: suffix,
            suffixStyle: const TextStyle(
              color: accentcolor,
              fontFamily: 'cairo',
            )),
        validator: validators[validator]);
  }
}
