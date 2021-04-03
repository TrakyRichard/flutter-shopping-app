import 'package:flutter/material.dart';
import 'package:shopping/Widgets/AppBar.dart';
import 'package:shopping/Widgets/Buttons.dart';
import 'package:shopping/Widgets/TextField.dart';
import 'package:shopping/Widgets/TextTitle.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String _email, _password, _username;
  bool _isSubmitting = false, _isObsur = true;

  void _snackBar({Color color, Widget child}) {
    final snackbar = SnackBar(
        content: Container(
      padding: EdgeInsets.symmetric(horizontal: 32, vertical: 8),
      color: color,
      child: child,
    ));
    ScaffoldMessenger.of(context).showSnackBar(snackbar);

    // _scaffoldKey.currentState.showSnackBar(snackbar);
  }

  void _registerUser() {
    print('OK');
    var url = Uri.parse("http://localhost:4242/auth/local/register");
    setState(() {
      _isSubmitting = true;
    });
    http.post(url, body: {
      "username": _username,
      "email": _email,
      "password": _password,
    }).then((value) {
      print(value);
      final response = json.decode(value.body);
      print(value.body);
      if (value.statusCode == 200) {
        print(value.body);

        _snackBar(
            child: Text("Welcome to shopping App $_username"),
            color: Colors.green);
      } else {
        String errMsg = response["message"];

        _snackBar(child: Text(errMsg), color: Colors.redAccent);
        throw Exception("Error Register: $errMsg");
      }
    }).then((_) {
      setState(() {
        _isSubmitting = false;
        _email = _password = _username = "";
      });

      Future.delayed(Duration(seconds: 2), () {
        return Navigator.pushReplacementNamed(context, "/products");
      });
    }).catchError((err) {
      setState(() {
        _isSubmitting = false;
      });
      print(err);
    });
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
      key: _scaffoldKey,
      appBar: appBar(context: context),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: Center(
          child: SingleChildScrollView(
            child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    textTitle(context: context, title: "Register"),
                    TextFormWidget(
                      hintText: "Your name",
                      onSaved: (val) => _username = val,
                      iconData: Icons.face,
                      suffix: SizedBox.shrink(),
                      labelText: "Name",
                      validator: (val) => val.length < 6
                          ? "This name must be greather than 6"
                          : null,
                      isObsurr: false,
                    ),
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
                        onPressed: () {
                          setState(() {
                            _isObsur = !_isObsur;
                          });
                        },
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
                    Column(
                      children: [
                        !_isSubmitting
                            ? submitButton(function: _onSubmit)
                            : CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation(
                                    Theme.of(context).accentColor),
                              ),
                        SizedBox(
                          height: 80,
                        ),
                        textButton(
                            function: () => Navigator.pushReplacementNamed(
                                context, "/login"),
                            text: "Existing user Login ?")
                      ],
                    )
                  ],
                )),
          ),
        ),
      ),
    );
  }
}
