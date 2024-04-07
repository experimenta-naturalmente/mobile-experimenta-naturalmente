import 'package:equatable/equatable.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

class LoginInitial extends LoginState {
  final bool obscuredPassword;
  const LoginInitial(this.obscuredPassword);
  @override
  List<Object> get props => [obscuredPassword];
}

class LoginSubmitLoading extends LoginState {}

class LoginSubmitSucess extends LoginState {}

class LoginError extends LoginState {
  final String error;

  const LoginError(this.error);

  @override
  List<Object> get props => [error];
}
