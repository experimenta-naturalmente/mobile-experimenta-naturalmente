import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turismo_rural_frontend/features/auth/bloc/login_event.dart';
import 'package:turismo_rural_frontend/features/auth/bloc/login_state.dart';
import 'package:turismo_rural_frontend/features/experiences/data/interfaces/i_experience_repository.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final IExperienceRepository experienceRepository;

  // na declaração do bloc, cada evento é associado a uma função
  LoginBloc({
    required this.experienceRepository,
  }) : super(const LoginInitial(true)) {
    on<LoginSubmit>(_onLoginSubmit);
    on<LoginToggleObscuredText>(_onLoginToggleObscuredText);
  }

  Future<void> _onLoginSubmit(
    LoginSubmit event,
    Emitter<LoginState> emit,
  ) async {
    emit(LoginSubmitLoading());
    try {
      print("Passou");
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
