import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:turismo_rural_frontend/features/auth/bloc/login_bloc.dart';
import 'package:turismo_rural_frontend/features/auth/bloc/login_event.dart';
import 'package:turismo_rural_frontend/features/auth/bloc/login_state.dart';

void main() {
  group('LoginBloc', () {
    late LoginBloc loginBloc;

    // Configurações antes de cada teste
    setUp(() {
      loginBloc = LoginBloc();
    });

    blocTest<LoginBloc, LoginState>(
      'emits [LoginSubmitLoading] quando LoginSubmit é adicionado',
      build: () => loginBloc,
      act: (bloc) => bloc.add(const LoginSubmit("teste", "passwordtest")),
      expect: () => [LoginSubmitLoading()],
    );

    // Teste para verificar o comportamento ao enviar LoginToggleObscuredText
    blocTest<LoginBloc, LoginState>(
      'emits [LoginInitial] com o estado toggled quando LoginToggleObscuredText é adicionado',
      build: () => loginBloc,
      act: (bloc) => bloc.add(const LoginToggleObscuredText(true)),
      expect: () => [const LoginInitial(false)],
    );

    // Feche o bloco após cada teste
    tearDown(() {
      loginBloc.close();
    });
  });
}
