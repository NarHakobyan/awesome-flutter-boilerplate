import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:secure_chat/routes.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:secure_chat/mixins/Loading.dart';
import 'package:secure_chat/mixins/keyboard.dart';
import 'package:secure_chat/providers/get_it.dart';
import 'package:secure_chat/models/user/user.dart';
import 'package:secure_chat/config/application.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:secure_chat/components/button_component.dart';

class LoginPageComponent extends StatefulWidget {
  @override
  _LoginPageComponentState createState() => _LoginPageComponentState();
}

class _LoginPageComponentState extends State<LoginPageComponent>
    with Loading<LoginPageComponent> {
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  bool autoValidate = false;

  _loginHandler(context) async {
    final form = _fbKey.currentState;
    final dio = getIt<Dio>();

    if (form.validate() == false) {
      setState(() {
        autoValidate = true;
      });
      return;
    }

    form.save();

    try {
      Keyboard.hideKeyboard();
      startLoading();
      final response = await dio.post('/auth/login', data: form.value);

      // Store current [] info
      final user = User.fromJson(response.data);

      Application.router.navigateTo(context, Routes.rooms, clearStack: true);
    } on DioError catch (e) {
      Fluttertoast.showToast(
          msg: e.response.data['message'].toUpperCase(),
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
          Keyboard.hideKeyboard();
        },
        child: new LayoutBuilder(
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
                              style: TextStyle(
                                  fontSize: 22, color: themeData.primaryColor),
                            ),
                          ),
                          new Text(
                              'Secure communication for the 21st century'
                                  .toUpperCase(),
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.grey[400]))
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
                                  colors: <Color>[
                                    themeData.primaryColor,
                                    themeData.primaryColorDark
                                  ],
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
                                .navigateTo(context, Routes.register);
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
    return FormBuilder(
      key: _fbKey,
      autovalidate: autoValidate,
      child: Column(
        children: <Widget>[
          FormBuilderTextField(
              attribute: 'email',
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              validators: [
                FormBuilderValidators.email(),
                FormBuilderValidators.required(),
              ],
              decoration: InputDecoration(labelText: 'email'.toUpperCase())),
          FormBuilderTextField(
            attribute: 'password',
            decoration: InputDecoration(labelText: 'password'.toUpperCase()),
            obscureText: true,
            validators: [
              FormBuilderValidators.minLength(6),
              FormBuilderValidators.required(),
            ],
          ),
        ],
      ),
    );
  }
}
