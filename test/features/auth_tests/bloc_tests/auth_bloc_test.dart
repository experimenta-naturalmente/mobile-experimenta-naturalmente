import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:turismo_rural_frontend/core/data/repositories/user_repository.dart';
import 'package:turismo_rural_frontend/features/auth/bloc/login_bloc.dart';
import 'package:turismo_rural_frontend/features/auth/bloc/login_event.dart';
import 'package:turismo_rural_frontend/features/auth/bloc/login_state.dart';

void main() {
  group('LoginBloc', () {
    late LoginBloc loginBloc;
    late UserRepository userRepository;

    // Configurações antes de cada teste
    setUp(() {
      userRepository = UserRepository(apiUrl: 'API_URL');
      loginBloc = LoginBloc(userRepository: userRepository);
    });

    blocTest<LoginBloc, LoginState>(
      'emits [LoginSubmitLoading] quando LoginSubmit é adicionado',
      build: () => loginBloc,
      act: (bloc) => bloc.add(const LoginSubmit("teste", "passwordTest")),
      expect: () => [LoginSubmitLoading()],
    );

    // Test das props do login_event.
    test('LoginSubmit get props should return [user, password]', () {
      const event = LoginSubmit('user', 'password');
      expect(event.props, ['user', 'password']);
    });

    test('LoginToggleObscuredText get props should return [obscuredText]', () {
      const event = LoginToggleObscuredText(true);
      expect(event.props, [true]);
    });

    // Teste para verificar o comportamento ao enviar LoginToggleObscuredText
    blocTest<LoginBloc, LoginState>(
      'emits [LoginInitial] com o estado toggled quando LoginToggleObscuredText é adicionado',
      build: () => loginBloc,
      act: (bloc) => bloc.add(const LoginToggleObscuredText(true)),
      expect: () => [const LoginInitial(false)],
    );

    test('LoginError get props should return [error]', () {
      const state = LoginError('Test error');
      expect(state.props, ['Test error']);
    });

    // Feche o bloco após cada teste
    tearDown(() {
      loginBloc.close();
    });
  });
}
