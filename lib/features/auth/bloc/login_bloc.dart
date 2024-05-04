import 'package:flutter_bloc/flutter_bloc.dart';
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
    try {} catch (e) {
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
