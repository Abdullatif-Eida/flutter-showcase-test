import 'package:flutter_demo/core/domain/stores/user_store.dart';
import 'package:flutter_demo/features/auth/login/login_presentation_model.dart';
import 'package:flutter_demo/features/auth/login/login_presenter.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../app_init/mocks/app_init_mocks.dart';
import '../mocks/auth_mock_definitions.dart';

void main() {
  late LoginPresentationModel model;
  late LoginPresenter presenter;
  late MockLoginNavigator navigator;

  test(
    'sample test',
    () {
      expect(presenter, isNotNull); // TODO implement this
    },
  );

  setUp(() {
    model = LoginPresentationModel.initial();
    navigator = MockLoginNavigator();
    presenter = LoginPresenter(
      model,
      navigator,
      AppInitMocks.logInUseCase,
      UserStore(),
    );
  });
}
