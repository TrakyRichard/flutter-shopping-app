import 'package:flutter/material.dart';
import 'package:shopping/Constants/style.dart';

Container submitButton({Function function}) {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.symmetric(horizontal: 16),
    child: ElevatedButton(
        onPressed: function,
        child: Text("Login"),
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(horizontal: 64, vertical: 16),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadiusConst)),
        )),
  );
}

TextButton textButton({Function function, String text}) {
  return TextButton(
    onPressed: function,
    child: Text(
      text,
      style: TextStyle(color: Colors.grey),
    ),
    style: TextButton.styleFrom(
        textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
  );
}
