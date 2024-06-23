import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turismo_rural_frontend/core/data/interfaces/i_user_repository.dart';
import 'package:turismo_rural_frontend/core/data/models/user.dart';
import 'package:turismo_rural_frontend/features/auth/bloc/login_event.dart';
import 'package:turismo_rural_frontend/features/auth/bloc/login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final IUserRepository userRepository;

  LoginBloc({required this.userRepository}) : super(const LoginInitial(true)) {
    on<LoginSubmit>(_onLoginSubmit);
    on<LoginToggleObscuredText>(_onLoginToggleObscuredText);
  }

  Future<void> _onLoginSubmit(
    LoginSubmit event,
    Emitter<LoginState> emit,
  ) async {
    emit(LoginSubmitLoading());

    try {
      final User user = await userRepository.loginUser(
        event.user,
        event.password,
      );
      if (user.id != -1) {
        emit(LoginSubmitSucess(user));
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
