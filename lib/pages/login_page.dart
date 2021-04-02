import 'package:flutter/material.dart';
import 'package:shopping/Widgets/AppBar.dart';
import 'package:shopping/Widgets/Buttons.dart';
import 'package:shopping/Widgets/TextField.dart';
import 'package:shopping/Widgets/TextTitle.dart';
import 'package:shopping/pages/register_page.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _email, _password;
  bool _isObsur = true;

  void _onSubmit() {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      print(
          "This form is saved with email: $_email, and password: $_password,");
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
                      onSaved: (val) => val = _email,
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
                    submitButton(function: _onSubmit),
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
