import 'package:flutter/cupertino.dart';
import 'package:shopping/pages/login_page.dart';
import 'package:shopping/pages/register_page.dart';
import 'package:shopping/pages/product_page.dart';

var routes = {
  "/login": (BuildContext context) => LoginPage(),
  "/register": (BuildContext context) => RegisterPage(),
  "/products": (BuildContext context) => ProductPage()
};
