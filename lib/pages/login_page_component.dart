import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:secure_chat/components/button_component.dart';

import 'package:secure_chat/helpers/validators.dart';

class NewLoginModel {
  String email;
  String password;
}

class LoginPageComponent extends StatefulWidget {
  @override
  _LoginPageComponentState createState() => _LoginPageComponentState();
}

class _LoginPageComponentState extends State<LoginPageComponent> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  final loginModel = NewLoginModel();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  _loginHandler() async {
    final FormState form = _formKey.currentState;

    if (form.validate() == false) {
      return;
    }

    form.save();

    try {
      await _auth.signInWithEmailAndPassword(email: loginModel.email, password: loginModel.password);
    } catch (e) {
      Fluttertoast.showToast(
          msg: "Email or password is incorrect".toUpperCase(),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIos: 1,
          bgcolor: "#e74c3c",
          textcolor: '#ffffff'
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    var themeData = Theme.of(context);

    return Scaffold(
        key: _scaffoldKey,
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
                'Welcome to your secure chat'.toUpperCase(),
                style: TextStyle(fontSize: 22, color: themeData.primaryColor),
              ),
            ),
            Text('Secure communication for the 21st century'.toUpperCase(), style: TextStyle(color: Colors.grey[400]))
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: _buildForm(),
        )
      ],
    ));
  }

  _buildForm() {
      const textFieldLabelStyle = const TextStyle(letterSpacing: 2);
      ThemeData themeData = Theme.of(context);

      return Form(
          key: _formKey,
          child: Column(
              children: <Widget>[
                  TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      validator: (String value) {
                          if (value.isEmpty) {
                              return 'please fill the field'.toUpperCase();
                          }
                          if (!Validators.isValidEmail(value)) {
                              return 'please fill a valid email address'.toUpperCase();
                          }
                      },
                      onSaved: (email) {
                          loginModel.email = email;
                      },
                      decoration: InputDecoration(labelText: 'email'.toUpperCase(), labelStyle: textFieldLabelStyle)),
                  TextFormField(
                      validator: (String value) {
                          if (value.isEmpty) {
                              return 'please fill the field'.toUpperCase();
                          }
                          if (value.length < 6) {
                              return 'field must be more then 6 symbols'.toUpperCase();
                          }
                      },
                      onSaved: (password) {
                          loginModel.password = password;
                      },
                      decoration: InputDecoration(labelText: 'password'.toUpperCase(), labelStyle: textFieldLabelStyle),
                      obscureText: true,
                  ),
                  Container(
                      margin: EdgeInsets.only(top: 20),
                    child: ButtonComponent(
                        colors: <Color>[themeData.primaryColor, themeData.primaryColorDark],
                        onTap: _loginHandler,
                        child: Text(
                        'login'.toUpperCase(),
                        style: TextStyle(color: Colors.white),
                    ),),
                  ),
              ],
          ),
      );
  }
}
