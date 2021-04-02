import 'package:flutter/material.dart';

class TextFormWidget extends StatelessWidget {
  final String labelText;
  final String hintText;
  final IconData iconData;
  final Function validator;
  final bool isObsurr;
  final Function onSaved;
  final Widget suffix;

  TextFormWidget(
      {Key key,
      this.labelText,
      this.hintText,
      this.iconData,
      this.validator,
      this.isObsurr,
      this.onSaved,
      this.suffix})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
        child: TextFormField(
          onSaved: onSaved,
          validator: validator,
          obscureText: isObsurr,
          decoration: InputDecoration(
              icon: Icon(iconData),
              suffixIcon: suffix,
              hintText: hintText,
              labelText: labelText,
              border: OutlineInputBorder()),
        ),
      ),
    );
  }
}
