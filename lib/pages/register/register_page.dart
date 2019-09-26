import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:secure_chat/helpers/keyboard_helper.dart';
import 'package:secure_chat/helpers/toast_helper.dart';
import 'package:secure_chat/routes.dart';
import 'package:secure_chat/store/form_group/form_group_state.dart';
import 'package:secure_chat/store/loading/loading_state.dart';
import 'package:secure_chat/store/register/register_state.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();
  final Router router = GetIt.I<Router>();
  final FormGroupState formState = FormGroupState();
  final RegisterState registerState = RegisterState();
  final LoadingState loadingStore = LoadingState();

  Future<void> _registerHandler() async {
    final FormBuilderState form = _fbKey.currentState;

    if (!form.validate()) {
      formState.setAutoValidate(autoValidate: true);
      return;
    }

    form.save();

    await registerState.registerUser(form.value);
    await ToastHelper.showToast('you have successfully registered.');
    await router.navigateTo(context, Routes.rooms, clearStack: true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: KeyboardHelper.hideKeyboard,
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints viewportConstraints) {
            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: viewportConstraints.maxHeight,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    const Padding(
                      padding: EdgeInsets.only(top: 40),
                      child: FlutterLogo(size: 100),
                    ),
                    _buildForm(),
                    Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          child: FlatButton(
                            onPressed: _registerHandler,
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
                            style: const TextStyle(fontSize: 19),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        const SizedBox(
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

  Observer _buildForm() {
    return Observer(
      builder: (BuildContext context) {
        return FormBuilder(
            key: _fbKey,
            autovalidate: formState.autoValidate,
            child: Column(
              children: <Widget>[
                FormBuilderTextField(
                  attribute: 'firstName',
                  decoration:
                      InputDecoration(labelText: 'First name'.toUpperCase()),
                  validators: <FormFieldValidator<dynamic>>[
                    FormBuilderValidators.required(),
                    FormBuilderValidators.minLength(4),
                  ],
                ),
                FormBuilderTextField(
                  attribute: 'lastName',
                  decoration:
                      InputDecoration(labelText: 'last name'.toUpperCase()),
                  validators: <FormFieldValidator<dynamic>>[
                    FormBuilderValidators.required(),
                    FormBuilderValidators.minLength(4),
                  ],
                ),
                FormBuilderTextField(
                  attribute: 'email',
                  decoration: InputDecoration(labelText: 'email'.toUpperCase()),
                  validators: <FormFieldValidator<dynamic>>[
                    FormBuilderValidators.email(),
                    FormBuilderValidators.required(),
                  ],
                ),
                FormBuilderTextField(
                  attribute: 'password',
                  decoration:
                      InputDecoration(labelText: 'password'.toUpperCase()),
                  obscureText: true,
                  validators: <FormFieldValidator<dynamic>>[
                    FormBuilderValidators.required(),
                    FormBuilderValidators.minLength(6),
                  ],
                ),
              ],
            ));
      },
    );
  }
}
