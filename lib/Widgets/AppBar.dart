import 'package:flutter/material.dart';

AppBar appBar({BuildContext context}) {
  return AppBar(
    title: Text("Shopping App", style: Theme.of(context).textTheme.headline6),
    backgroundColor: Colors.transparent,
    elevation: 0.0,
  );
}
