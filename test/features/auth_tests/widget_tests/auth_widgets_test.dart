import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:turismo_rural_frontend/core/widgets/shared/error_handler.dart';
import 'package:turismo_rural_frontend/core/widgets/shared/loading_indicator.dart';
import 'package:turismo_rural_frontend/core/widgets/shared/submit_button.dart';
import 'package:turismo_rural_frontend/features/auth/bloc/login_bloc.dart';
import 'package:turismo_rural_frontend/features/auth/bloc/login_event.dart';
import 'package:turismo_rural_frontend/features/auth/bloc/login_state.dart';
import 'package:turismo_rural_frontend/features/auth/presentation/screens/login.dart';

class MockLoginBloc extends MockBloc<LoginEvent, LoginState>
    implements LoginBloc {}

void main() {
  late MockLoginBloc mockLoginBloc;

  // Configurações antes de cada teste
  setUp(() {
    mockLoginBloc = MockLoginBloc();
  });

  // Fecha o bloco após cada teste
  tearDown(() {
    mockLoginBloc.close();
  });

  // Função auxiliar para criar um widget de teste
  Widget createTestableWidget(Widget child) {
    return MaterialApp(
      home: BlocProvider<LoginBloc>(
        create: (context) => mockLoginBloc,
        child: Scaffold(
          body: child,
        ),
      ),
    );
  }

  // Teste para verificar se o `LoadingIndicator` é exibido durante o carregamento do envio
  testWidgets(
      'should display LoadingIndicator when LoginSubmitLoading state is present',
      (WidgetTester tester) async {
    // Configura o `mockLoginBloc` com um estado inicial de carregamento
    whenListen(
      mockLoginBloc,
      Stream.fromIterable([LoginSubmitLoading()]),
      initialState: LoginSubmitLoading(),
    );

    // Renderiza a tela de login
    await tester.pumpWidget(createTestableWidget(const LoginScreen()));

    // Verifica se o `LoadingIndicator` está presente
    expect(find.byType(LoadingIndicator), findsOneWidget);
  });

  // Teste para verificar se o `ErrorHandler` é exibido quando o estado é `LoginError`
  testWidgets('should display ErrorHandler when LoginError state is present',
      (WidgetTester tester) async {
    // Configura o `mockLoginBloc` com um estado de erro
    whenListen(
      mockLoginBloc,
      Stream.fromIterable([const LoginSubmitError('Test error')]),
      initialState: const LoginSubmitError('Test error'),
    );

    // Renderiza a tela de login
    await tester.pumpWidget(createTestableWidget(const LoginScreen()));

    // Verifica se o `ErrorHandler` está presente
    expect(find.byType(ErrorHandler), findsOneWidget);
  });

  // Teste para verificar o estado inicial e os campos do formulário na tela de login
  testWidgets('should display login form in initial state',
      (WidgetTester tester) async {
    // Configura o `mockLoginBloc` com um estado inicial
    whenListen(
      mockLoginBloc,
      Stream.fromIterable([const LoginInitial(true)]),
      initialState: const LoginInitial(true),
    );

    // Renderiza a tela de login
    await tester.pumpWidget(createTestableWidget(const LoginScreen()));

    // Verifica se o formulário de login está presente
    expect(find.byType(TextFormField), findsNWidgets(2)); // Usuário e senha
    expect(find.byType(SubmitButton), findsOneWidget); // Botão de envio
  });
}
