import 'package:flutter/material.dart';

class AppText extends StatelessWidget {
  String text;
  String descricao;
  bool password;
  TextEditingController controller;
  FormFieldValidator<String> validator;
  TextInputType keyboardType;
  TextInputAction textInputAction;
  FocusNode focusNode;
  FocusNode nextFocus;

  AppText(
    this.text,
    this.descricao, {
    this.password  = false,
    this.controller,
    this.validator,
    this.keyboardType,
    this.textInputAction,
    this.focusNode,
    this.nextFocus,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onFieldSubmitted: (String text) {
        if (nextFocus != null) {
          FocusScope.of(context).requestFocus(nextFocus);
        }
      },
      focusNode: focusNode,
      textInputAction: textInputAction,
      keyboardType: keyboardType,
      validator: validator,
      controller: controller,
      obscureText: password,
      style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 25),
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
        ),
          labelText: text,
          labelStyle: TextStyle(color: Colors.grey, fontSize: 25),
          hintText: descricao),
    );
  }
}
