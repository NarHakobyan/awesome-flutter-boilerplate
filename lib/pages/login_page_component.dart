import 'package:flutter/material.dart';

class LoginPageComponent extends StatefulWidget {
  @override
  _LoginPageComponentState createState() => _LoginPageComponentState();
}

class _LoginPageComponentState extends State<LoginPageComponent> {
  final _formKey = GlobalKey<FormState>();

  var usernameController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var textFieldLabelStyle = TextStyle(letterSpacing: 2);

    var themeData = Theme.of(context);

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
                style: TextStyle(fontSize: 22, color: themeData.primaryColor),
              ),
            ),
            Text('Team communication for the 21st century'.toUpperCase(), style: TextStyle(color: Colors.grey[400]))
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                TextFormField(
                    validator: (String value) {
                      if (value.isEmpty) {
                        return 'please fill the field';
                      }
                    },
                    controller: usernameController,
                    decoration: InputDecoration(labelText: 'username'.toUpperCase(), labelStyle: textFieldLabelStyle)),
                TextFormField(
                  validator: (String value) {
                    if (value.isEmpty) {
                      return 'please fill the field'.toUpperCase();
                    }
                    if (value.length < 6) {
                      return 'field must be more then 6 symbols'.toUpperCase();
                    }
                  },
                  controller: passwordController,
                  decoration: InputDecoration(labelText: 'password'.toUpperCase(), labelStyle: textFieldLabelStyle),
                  obscureText: true,
                ),
                Container(
                  width: 250,
                  height: 50.0,
                  margin: EdgeInsets.only(top: 50),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.horizontal(left: Radius.circular(50), right: Radius.circular(50)),
                      gradient: LinearGradient(
                        colors: <Color>[themeData.primaryColor, themeData.primaryColorDark],
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey[500],
                          offset: Offset(0.0, 1.5),
                          blurRadius: 1.5,
                        ),
                      ]),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                        onTap: () {
                            final FormState form = _formKey.currentState;

                            if(form.validate() == false) {
                                return;
                            }

                            print(usernameController.value.text);
                            print(passwordController.value.text);


                        },
                        child: Center(
                          child: Text(
                            'login'.toUpperCase(),
                            style: TextStyle(color: Colors.white),
                          ),
                        )),
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    ));
  }
}
