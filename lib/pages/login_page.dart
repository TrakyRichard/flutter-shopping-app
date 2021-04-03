import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shopping/Widgets/AppBar.dart';
import 'package:shopping/Widgets/Buttons.dart';
import 'package:shopping/Widgets/TextField.dart';
import 'package:shopping/Widgets/TextTitle.dart';
import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _email, _password;
  bool _isSubmitting = false, _isObsur = true;

  void _snackBar({Color color, Widget child}) {
    final snackbar = SnackBar(
        backgroundColor: color,
        content: Container(
          height: 32.0,
          decoration: BoxDecoration(),
          child: child,
        ));
    ScaffoldMessenger.of(context).showSnackBar(snackbar);

    // _scaffoldKey.currentState.showSnackBar(snackbar);
  }

  void _registerUser() async {
    var url = Uri.parse("http://localhost:4242/auth/local");
    setState(() {
      _isSubmitting = true;
    });
    final response = await http.post(url, body: {
      "identifier": _email,
      "password": _password,
    });

    // print(response.statusCode);
    final dynamic responseBody = await json.decode(response.body);
    if (response.statusCode == 200) {
      // print("Respnse Body" + responseBody.data.toString());
      _snackBar(
          child: Text("Welcome back to shopping",
              style: TextStyle(color: Colors.white)),
          color: Colors.green);
      setState(() {
        _isSubmitting = false;
        _email = _password = "";
      });
      return Future.delayed(Duration(seconds: 2), () {
        return Navigator.pushReplacementNamed(context, "/products");
      });
    } else if (response.statusCode != 200) {
      dynamic errMsg = responseBody["message"];
      // print("My errorr" + errMsg);

      _snackBar(
          child: Text(errMsg.toString(), style: TextStyle(color: Colors.white)),
          color: Colors.redAccent);
      setState(() {
        _isSubmitting = false;
        _email = _password = "";
      });
      // throw Exception("Error logging: $errMsg, $responseBody");
    }
  }

  void _onSubmit() {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      _registerUser();
    } else {
      print("Not validated yet");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBar(context: context),
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Center(
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    textTitle(context: context, title: "Login"),
                    TextFormWidget(
                      hintText: "Your email",
                      onSaved: (val) => _email = val,
                      iconData: Icons.email,
                      suffix: SizedBox.shrink(),
                      labelText: "Email",
                      validator: (val) => !val.contains('@')
                          ? "This is not a email format"
                          : null,
                      isObsurr: false,
                    ),
                    TextFormWidget(
                      hintText: "Your Password",
                      onSaved: (val) => _password = val,
                      iconData: Icons.lock,
                      suffix: IconButton(
                        onPressed: () => setState(() {
                          _isObsur = !_isObsur;
                        }),
                        icon: Icon(
                            _isObsur ? Icons.visibility : Icons.visibility_off),
                      ),
                      labelText: "Password",
                      validator: (val) => val.length < 6
                          ? "This password must be greather than 6"
                          : null,
                      isObsurr: _isObsur,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    _isSubmitting
                        ? CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation(
                            Theme.of(context).accentColor,
                          ))
                        : submitButton(function: _onSubmit),
                    SizedBox(
                      height: 80,
                    ),
                    textButton(
                        function: () => Navigator.pushReplacementNamed(
                            context, "/register"),
                        text: "Already signup ? register here")
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
