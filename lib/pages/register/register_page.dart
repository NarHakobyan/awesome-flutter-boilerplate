import 'package:dio/dio.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:secure_chat/widget/button_component.dart';
import 'package:secure_chat/config/application.dart';
import 'package:secure_chat/mixins/keyboard.dart';
import 'package:secure_chat/models/user/user.dart';
import 'package:secure_chat/providers/get_it.dart';
import 'package:secure_chat/routes.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  bool autovalidate = false;
  final router = getIt<Router>();

  _registerHandler() async {
    final dio = getIt<Dio>();

    final form = _fbKey.currentState;

    if (form.validate() == false) {
      setState(() {
        autovalidate = true;
      });
      return;
    }

    form.save();

    try {
      //TODO move to service folder
      final response = await dio.post('/auth/register', data: form.value);

      // Store current [] info
      final user = User.fromJson(response.data);

      Fluttertoast.showToast(
          msg: "you have successfully registered.".toUpperCase(),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIos: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white);

      router.navigateTo(context, Routes.rooms, clearStack: true);
    } on DioError catch (e) {
      if (e.response.statusCode == 409) {
        Fluttertoast.showToast(
            msg: e.response.data['message'],
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIos: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white);
        return;
      }
      print(e);
    }
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
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints viewportConstraints) {
            return SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: ConstrainedBox(
                constraints: BoxConstraints(
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
                    Column(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 20),
                          child: ButtonComponent(
                            colors: <Color>[
                              themeData.primaryColor,
                              themeData.primaryColorDark
                            ],
                            onTap: _registerHandler,
                            child: Text(
                              'Sign up'.toUpperCase(),
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                        FlatButton(
                          onPressed: () {
                            router.navigateTo(context, Routes.login,
                                clearStack: true,
                                transition: TransitionType.nativeModal);
                          },
                          child: Text(
                            'already have an account?'.toUpperCase(),
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

  _buildForm() {
    return FormBuilder(
        key: _fbKey,
        autovalidate: autovalidate,
        child: Column(
          children: <Widget>[
            FormBuilderTextField(
              attribute: 'firstName',
              decoration:
                  InputDecoration(labelText: 'First name'.toUpperCase()),
              validators: [
                FormBuilderValidators.required(),
                FormBuilderValidators.minLength(4),
              ],
            ),
            FormBuilderTextField(
              attribute: 'lastName',
              decoration: InputDecoration(labelText: 'last name'.toUpperCase()),
              validators: [
                FormBuilderValidators.required(),
                FormBuilderValidators.minLength(4),
              ],
            ),
            FormBuilderTextField(
              attribute: 'email',
              decoration: InputDecoration(labelText: 'email'.toUpperCase()),
              validators: [
                FormBuilderValidators.email(),
                FormBuilderValidators.required(),
              ],
            ),
            FormBuilderTextField(
              attribute: 'password',
              decoration: InputDecoration(labelText: 'password'.toUpperCase()),
              obscureText: true,
              validators: [
                FormBuilderValidators.required(),
                FormBuilderValidators.minLength(6),
              ],
            ),
          ],
        ));
  }
}
