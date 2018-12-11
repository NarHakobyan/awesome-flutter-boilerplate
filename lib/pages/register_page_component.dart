import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:secure_chat/components/button_component.dart';
import 'package:secure_chat/config/application.dart';
import 'package:secure_chat/helpers/validators.dart';
import 'package:secure_chat/routes.dart';

class NewRegisterModel {
  String displayName;
  String email;
  String password;

  @override
  String toString() {
    return 'NewRegisterModel{displayName: $displayName, email: $email, password: $password}';
  }
}

class RegisterPageComponent extends StatefulWidget {
  @override
  _RegisterPageComponentState createState() => _RegisterPageComponentState();
}

class _RegisterPageComponentState extends State<RegisterPageComponent> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();


  final _displayNameFocus = FocusNode();
  final _emailFocus = FocusNode();
  final _passwordFocus = FocusNode();

  final registerModel = NewRegisterModel();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  _registerHandler() async {
    final FormState form = _formKey.currentState;

    if (form.validate() == false) {
      return;
    }

    form.save();

    try {
      FirebaseUser user =
          await _auth.createUserWithEmailAndPassword(email: registerModel.email, password: registerModel.password);
      UserUpdateInfo userUpdateInfo = UserUpdateInfo()..displayName = registerModel.displayName;
      await user.updateProfile(userUpdateInfo);

      Fluttertoast.showToast(
          msg: "you have successfully registered.".toUpperCase(),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIos: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white);

      Application.currentUser = user;

      Application.router.navigateTo(context, Routes.rooms, clearStack: true);
    } catch (e) {
      Fluttertoast.showToast(
          msg: e.details.toUpperCase(),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIos: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white);
    }
  }

  @override
  Widget build(BuildContext context) {
    var themeData = Theme.of(context);

    return Scaffold(
      key: _scaffoldKey,
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints viewportConstraints) {
          return SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: new ConstrainedBox(
              constraints: new BoxConstraints(
                minHeight: viewportConstraints.maxHeight,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 40),
                    child: FlutterLogo(size: 100),
                  ),
                  _buildForm(),
                  new Column(
                    children: <Widget>[
                      new Padding(
                        padding: EdgeInsets.symmetric(vertical: 20),
                        child: ButtonComponent(
                          colors: <Color>[themeData.primaryColor, themeData.primaryColorDark],
                          onTap: _registerHandler,
                          child: Text(
                            'Sign up'.toUpperCase(),
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      new FlatButton(
                        onPressed: () {
                          Application.router
                              .navigateTo(context, Routes.login, replace: true, transition: TransitionType.nativeModal);
                        },
                        child: Text(
                          'already have an account?'.toUpperCase(),
                          style: TextStyle(fontSize: 19),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  _buildForm() {
    const textFieldLabelStyle = const TextStyle(letterSpacing: 2);

    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          TextFormField(
              keyboardType: TextInputType.text,
              maxLines: 1,
              textInputAction: TextInputAction.next,
              focusNode: _displayNameFocus,
              onFieldSubmitted: (_) {
                _displayNameFocus.unfocus();
                FocusScope.of(context).requestFocus(_emailFocus);
              },
              validator: (String value) {
                if (value.isEmpty) {
                  return 'please fill the field'.toUpperCase();
                }
              },
              onSaved: (value) {
                registerModel.displayName = value;
              },
              decoration: InputDecoration(labelText: 'display name'.toUpperCase(), labelStyle: textFieldLabelStyle)),
          TextFormField(
              keyboardType: TextInputType.emailAddress,
              maxLines: 1,
              textInputAction: TextInputAction.next,
              focusNode: _emailFocus,
              onFieldSubmitted: (_) {
                _emailFocus.unfocus();
                print(_passwordFocus.hasFocus);
                FocusScope.of(context).requestFocus(_passwordFocus);
              },
              validator: (String value) {
                if (value.isEmpty) {
                  return 'please fill the field'.toUpperCase();
                }
                if (!Validators.isValidEmail(value)) {
                  return 'please fill a valid email address'.toUpperCase();
                }
              },
              onSaved: (email) {
                registerModel.email = email;
              },
              decoration: InputDecoration(labelText: 'email'.toUpperCase(), labelStyle: textFieldLabelStyle)),
          TextFormField(
            maxLines: 1,
            focusNode: _passwordFocus,
            onFieldSubmitted: (_) {
              _passwordFocus.unfocus();

              _registerHandler();
            },
            validator: (String value) {
              if (value.isEmpty) {
                return 'please fill the field'.toUpperCase();
              }
              if (value.length < 6) {
                return 'field must be more then 6 symbols'.toUpperCase();
              }
            },
            onSaved: (password) {
              registerModel.password = password;
            },
            decoration: InputDecoration(labelText: 'password'.toUpperCase(), labelStyle: textFieldLabelStyle),
            obscureText: true,
          ),
        ],
      ),
    );
  }
}
