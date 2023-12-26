import 'package:bloc/bloc.dart';
import 'package:flutter_demo/core/domain/stores/user_store.dart';
import 'package:flutter_demo/core/utils/bloc_extensions.dart';
import 'package:flutter_demo/core/utils/either_extensions.dart';
import 'package:flutter_demo/features/auth/domain/use_cases/log_in_use_case.dart';
import 'package:flutter_demo/features/auth/login/login_navigator.dart';
import 'package:flutter_demo/features/auth/login/login_presentation_model.dart';
import 'package:flutter_demo/navigation/alert_dialog_route.dart';
import 'package:flutter_demo/navigation/error_dialog_route.dart';

class LoginPresenter extends Cubit<LoginViewModel> with AlertDialogRoute, ErrorDialogRoute {
  LoginPresenter(
    LoginPresentationModel super.model,
    this.navigator,
    this.logInUseCase,
    this.userStore,
  );

  final LoginNavigator navigator;
  final LogInUseCase logInUseCase;
  final UserStore userStore;
  // ignore: unused_element
  LoginPresentationModel get _model => state as LoginPresentationModel;

  void updateFields(String newUsername, String newPassword) {
    final updatedModel = _model.copyWith(username: newUsername, password: newPassword);
    emit(updatedModel);
  }

  Future<void> onLoginButtonClicked() async {
    await logInUseCase
        .execute(
          username: _model.username,
          password: _model.password,
        ) //
        .observeStatusChanges((result) => emit(_model.copyWith(appInitResult: result)))
        .asyncFold(
      (fail) {
        // Handle failure
        showAlert(
          title: "Error",
          message: "${fail.type.name} Error Occurred", // You can customize this error message based on the failure type.
        );
      },
      (success) {
        // Handle success
        showAlert(
          title: "Success",
          message: "Login successful!",
        );
      },
    );
  }
}
