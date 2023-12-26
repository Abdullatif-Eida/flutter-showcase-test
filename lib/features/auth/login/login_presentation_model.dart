import 'package:dartz/dartz.dart';
import 'package:flutter_demo/core/domain/model/app_init_failure.dart';
import 'package:flutter_demo/core/domain/model/user.dart';
import 'package:flutter_demo/core/utils/bloc_extensions.dart';
import 'package:flutter_demo/features/auth/domain/model/log_in_failure.dart';
import 'package:flutter_demo/features/auth/login/login_initial_params.dart';

class LoginPresentationModel implements LoginViewModel {
  // Constructor
  LoginPresentationModel.initial(
    LoginInitialParams initialParams,
  )   : appInitResult = const FutureResult.empty(),
        username = '',
        password = '';

  // Private constructor for copyWith
  LoginPresentationModel._({
    required this.appInitResult,
  });
  final FutureResult<Either<LogInFailure, User>> appInitResult;

  @override
  String username = ''; // Initialize with empty string
  @override
  String password = ''; // Initialize with empty string

  @override
  bool get isLoginEnabled => username.isNotEmpty && password.isNotEmpty;
  @override
  bool get isLoading => appInitResult.isPending();

  LoginPresentationModel copyWith({
    bool? isLoginEnabled,
    String? username,
    String? password,
    FutureResult<Either<LogInFailure, User>>? appInitResult,
  }) {
    return LoginPresentationModel._(appInitResult: appInitResult ?? this.appInitResult)
      ..username = username ?? this.username
      ..password = password ?? this.password;
  }

  void updateFields(String newUsername, String newPassword) {
    username = newUsername; // Update username
    password = newPassword; // Update password
    copyWith(username: newUsername, password: newPassword);
  }
}

abstract class LoginViewModel {
  String get username;
  String get password;
  bool get isLoginEnabled;
  bool get isLoading;
}
