import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turismo_rural_frontend/core/data/interfaces/i_experience_repository.dart';
import 'package:turismo_rural_frontend/core/data/interfaces/i_user_repository.dart';
import 'package:turismo_rural_frontend/core/data/models/spot.dart';
import 'package:turismo_rural_frontend/core/data/models/user.dart';
import 'package:turismo_rural_frontend/features/auth/bloc/login_event.dart';
import 'package:turismo_rural_frontend/features/auth/bloc/login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final IUserRepository userRepository;
  final IExperienceRepository experienceRepository;

  LoginBloc({required this.userRepository, required this.experienceRepository})
      : super(const LoginInitial(true)) {
    on<LoginSubmit>(_onLoginSubmit);
    on<LoginToggleObscuredText>(_onLoginToggleObscuredText);
    on<LoginClear>(_onLoginClear);
    on<LoginLoadExperiences>(_onLoginLoadExperiences);
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
        emit(ProfileLoading(user));
        final Set<Spot> spotsBusiness =
            await experienceRepository.fetchSpotsByProfileId(user.id);
        emit(ProfileSuccess(user, spotsBusiness));
      } else {
        emit(const LoginSubmitError('Erro na autenticação'));
      }
    } catch (e) {
      emit(LoginSubmitError(e.toString()));
    }
  }

  Future<void> _onLoginLoadExperiences(
    LoginLoadExperiences event,
    Emitter<LoginState> emit,
  ) async {
    if (state is! ProfileSuccess) {
      return;
    }
    final user = (state as ProfileSuccess).user;
    emit(ProfileLoading(user));
    try {
      final Set<Spot> spotsBusiness =
          await experienceRepository.fetchSpotsByProfileId(user.id);
      emit(ProfileSuccess(user, spotsBusiness));
    } catch (e) {
      emit(ProfileError(user, e.toString()));
    }
  }

  Future<void> _onLoginToggleObscuredText(
    LoginToggleObscuredText event,
    Emitter<LoginState> emit,
  ) async {
    emit(LoginInitial(!event.obscuredText));
  }

  Future<void> _onLoginClear(
    LoginClear event,
    Emitter<LoginState> emit,
  ) async {
    emit(const LoginInitial(true));
  }
}
