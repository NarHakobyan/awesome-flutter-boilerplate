import 'package:flutter/material.dart';

class LoginPageComponent extends StatefulWidget {
  @override
  _LoginPageComponentState createState() => _LoginPageComponentState();
}

class _LoginPageComponentState extends State<LoginPageComponent> {
  final _formKey = GlobalKey<FormState>();

  var loginController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var textFieldlLabelStyle = TextStyle(letterSpacing: 2);

    return Scaffold(
        body: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            FlutterLogo(
              size: 100,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 30),
              child: Text(
                'Welcome to very secure chat'.toUpperCase(),
                style: TextStyle(fontSize: 22, color: Colors.grey[600]),
              ),
            ),
            Text('Team communication for the 21st century'.toUpperCase(), style: TextStyle(color: Colors.grey[400]))
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Form(
            key: _formKey,
            autovalidate: true,
            child: Column(
              children: <Widget>[
                TextField(
                    controller: loginController,
                    decoration: InputDecoration(labelText: 'username'.toUpperCase(), labelStyle: textFieldlLabelStyle)),
                TextField(
                  controller: passwordController,
                  decoration: InputDecoration(labelText: 'password'.toUpperCase(), labelStyle: textFieldlLabelStyle),
                  obscureText: true,
                )
              ],
            ),
          ),
        )
      ],
    ));
  }
}
