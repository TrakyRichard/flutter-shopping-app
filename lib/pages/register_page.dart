import 'package:flutter/material.dart';
import 'package:shopping/Widgets/AppBar.dart';
import 'package:shopping/Widgets/Buttons.dart';
import 'package:shopping/Widgets/TextField.dart';
import 'package:shopping/Widgets/TextTitle.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    String _email, _password, _username;
    bool _isObsur = true;

    void _onSubmit() {
      final form = _formKey.currentState;
      if (form.validate()) {
        form.save();
        print(
            "This form is saved with name: $_username email: $_email, and password: $_password,");
      } else {
        print("Not validated yet");
      }
    }

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
                          setState(() => _isObsur = !_isObsur);
                        },
                        icon: _isObsur ? Text("Oui") : Text("Non"),
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
                        submitButton(function: _onSubmit),
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
