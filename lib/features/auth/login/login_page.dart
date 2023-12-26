// ignore: unused_import
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/core/helpers.dart';
import 'package:flutter_demo/core/utils/mvp_extensions.dart';
import 'package:flutter_demo/features/auth/login/login_initial_params.dart';
import 'package:flutter_demo/features/auth/login/login_presentation_model.dart';
import 'package:flutter_demo/features/auth/login/login_presenter.dart';
import 'package:flutter_demo/localization/app_localizations_utils.dart';

class LoginPage extends StatefulWidget with HasPresenter<LoginPresenter> {
  const LoginPage({
    required this.presenter,
    super.key,
  });

  @override
  final LoginPresenter presenter;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

const initParams = LoginInitialParams();

class _LoginPageState extends State<LoginPage> with PresenterStateMixin<LoginViewModel, LoginPresenter, LoginPage> {
  final LoginPresentationModel _presentationModel = LoginPresentationModel.initial(initParams); // Initialize the presentation model
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) => Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: _usernameController,
                decoration: InputDecoration(
                  hintText: appLocalizations.usernameHint,
                ),
                onChanged: (text) => {
                  presenter.updateFields(text, _passwordController.text), // Update isLoginEnabled
                },
              ),
              const SizedBox(height: 8),
              TextField(
                obscureText: true,
                controller: _passwordController,
                decoration: InputDecoration(
                  hintText: appLocalizations.passwordHint,
                ),
                onChanged: (text) => {
                  presenter.updateFields(_usernameController.text, text), // Update isLoginEnabled
                },
              ),
              const SizedBox(height: 16),
              stateObserver(
                builder: (context, state) => state.isLoading
                    ? const CircularProgressIndicator()
                    : ElevatedButton(
                        onPressed: state.isLoginEnabled
                            ? () => presenter.onLoginButtonClicked()
                            : doNothing(), // Use isLoginEnabled to control the enabled state
                        child: Text(appLocalizations.logInAction),
                      ),
              ),
            ],
          ),
        ),
      );
}
