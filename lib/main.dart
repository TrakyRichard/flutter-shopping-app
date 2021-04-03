import 'package:flutter/material.dart';
import 'package:shopping/App/routes.dart';
import 'package:shopping/pages/login_page.dart';
import 'package:shopping/pages/register_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shopping App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          brightness: Brightness.dark,
          primaryColor: Colors.cyan[300],
          accentColor: Colors.cyan[900],
          textTheme: TextTheme(
            headline6: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          )),
      routes: routes,
      initialRoute: "/register",
    );
  }
}
