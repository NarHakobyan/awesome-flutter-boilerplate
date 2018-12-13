import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:secure_chat/components/button_component.dart';
import 'package:secure_chat/config/application.dart';
import 'package:secure_chat/helpers/validators.dart';
import 'package:secure_chat/mixins/Loading.dart';
import 'package:secure_chat/mixins/keyboard.dart';
import 'package:secure_chat/routes.dart';

class NewLoginModel {
  String email;
  String password;

  @override
  String toString() {
    return 'NewLoginModel{email: $email, password: $password}';
  }
}

class LoginPageComponent extends StatefulWidget {
  @override
  _LoginPageComponentState createState() => _LoginPageComponentState();
}

class _LoginPageComponentState extends State<LoginPageComponent> with Keyboard, Loading<LoginPageComponent> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _emailFocus = FocusNode();
  final _passwordFocus = FocusNode();

  bool autoValidate = false;

  final loginModel = NewLoginModel();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  _loginHandler(context) async {
    final FormState form = _formKey.currentState;

    if (form.validate() == false) {
      setState(() {
        autoValidate = true;
      });
      return;
    }

    hideKeyboard();
    startLoading();

    form.save();

    try {
      Application.currentUser =
          await _auth.signInWithEmailAndPassword(email: loginModel.email, password: loginModel.password);

      Application.router.navigateTo(context, Routes.rooms, clearStack: true);
    } catch (e) {
      Fluttertoast.showToast(
          msg: "Email or password is incorrect".toUpperCase(),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIos: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white);
    }
    stopLoading();
  }

  @override
  Widget build(BuildContext context) {
    var themeData = Theme.of(context);

    return Scaffold(
      key: _scaffoldKey,
      body: GestureDetector(
        onTap: () {
          hideKeyboard();
        },
        child: LayoutBuilder(
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
                      child: new Column(
                        children: <Widget>[
                          FlutterLogo(size: 100),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 30),
                            child: new Text(
                              'Welcome to your secure chat'.toUpperCase(),
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 22, color: themeData.primaryColor),
                            ),
                          ),
                          new Text('Secure communication for the 21st century'.toUpperCase(),
                              textAlign: TextAlign.center, style: TextStyle(color: Colors.grey[400]))
                        ],
                      ),
                    ),
                    _buildForm(context),
                    new Column(
                      children: <Widget>[
                        new Padding(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          child: isLoading
                              ? Center(
                                  child: CircularProgressIndicator(),
                                )
                              : ButtonComponent(
                                  colors: <Color>[themeData.primaryColor, themeData.primaryColorDark],
                                  onTap: () => _loginHandler(context),
                                  child: Text(
                                    'Sign in'.toUpperCase(),
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                        ),
                        FlatButton(
                          onPressed: () {
                            Application.router
                                .navigateTo(context, Routes.register, transition: TransitionType.nativeModal);
                          },
                          child: Text(
                            'sign up for an account'.toUpperCase(),
                            style: TextStyle(fontSize: 19),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        )
                      ],
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  _buildForm(context) {
    const textFieldLabelStyle = const TextStyle(letterSpacing: 2);

    return Form(
      key: _formKey,
      autovalidate: autoValidate,
      child: Column(
        children: <Widget>[
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
                loginModel.email = email;
              },
              decoration: InputDecoration(labelText: 'email'.toUpperCase(), labelStyle: textFieldLabelStyle)),
          TextFormField(
            maxLines: 1,
            focusNode: _passwordFocus,
            onFieldSubmitted: (_) {
              _passwordFocus.unfocus();

              _loginHandler(context);
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
              loginModel.password = password;
            },
            decoration: InputDecoration(labelText: 'password'.toUpperCase(), labelStyle: textFieldLabelStyle),
            obscureText: true,
          ),
        ],
      ),
    );
  }
}
