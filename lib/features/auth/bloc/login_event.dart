import 'package:equatable/equatable.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class LoginSubmit extends LoginEvent {
  final String user;
  final String password;
  const LoginSubmit(this.user, this.password);

  @override
  List<Object> get props => [user, password];
}

class LoginLoadExperiences extends LoginEvent {}

class LoginClear extends LoginEvent {}

class LoginToggleObscuredText extends LoginEvent {
  final bool obscuredText;
  const LoginToggleObscuredText(this.obscuredText);

  @override
  List<Object> get props => [obscuredText];
}
