import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Text textTitle({BuildContext context, String title}) {
  return (Text(
    title,
    style: Theme.of(context)
        .textTheme
        .headline6
        .copyWith(fontWeight: FontWeight.bold, fontSize: 24),
  ));
}
