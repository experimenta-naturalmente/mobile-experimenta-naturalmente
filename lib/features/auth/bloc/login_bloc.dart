import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:turismo_rural_frontend/features/auth/bloc/login_event.dart';
import 'package:turismo_rural_frontend/features/auth/bloc/login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(const LoginInitial(true)) {
    on<LoginSubmit>(_onLoginSubmit);
    on<LoginToggleObscuredText>(_onLoginToggleObscuredText);
  }

  Future<void> _onLoginSubmit(
    LoginSubmit event,
    Emitter<LoginState> emit,
  ) async {
    emit(LoginSubmitLoading());

    try {
      // URL da API de login
      final url = Uri.parse('https://dummyjson.com/auth/login');

      // Corpo da requisição
      final body = jsonEncode({
        'username': event.user,
        'password': event.password,
      });

      // Fazendo a requisição POST
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: body,
      );

      if (response.statusCode == 200) {
        // Sucesso na autenticação
        final responseData = jsonDecode(response.body);
        print(responseData);
        emit(LoginSubmitSucess(responseData));
      } else {
        // Erro na autenticação
        emit(const LoginError('Erro na autenticação'));
      }
    } catch (e) {
      emit(LoginError(e.toString()));
    }
  }

  Future<void> _onLoginToggleObscuredText(
    LoginToggleObscuredText event,
    Emitter<LoginState> emit,
  ) async {
    emit(LoginInitial(!event.obscuredText));
  }
}
