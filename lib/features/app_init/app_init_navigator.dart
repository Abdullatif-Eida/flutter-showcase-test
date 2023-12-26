import 'package:flutter_demo/dependency_injection/app_component.dart';
import 'package:flutter_demo/features/auth/login/login_initial_params.dart';
import 'package:flutter_demo/features/auth/login/login_page.dart';
import 'package:flutter_demo/navigation/app_navigator.dart';
import 'package:flutter_demo/navigation/error_dialog_route.dart';
import 'package:flutter_demo/navigation/no_routes.dart';

class AppInitNavigator with NoRoutes, ErrorDialogRoute {
  AppInitNavigator(this.appNavigator);

  @override
  final AppNavigator appNavigator;

  void navigateToLoginPage() {
    final page = getIt<LoginPage>(param1: const LoginInitialParams());
    final loginPageRoute = materialRoute(page);
    appNavigator.pushReplacement(loginPageRoute);
  }
}
