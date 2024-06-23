import 'package:equatable/equatable.dart';
import 'package:turismo_rural_frontend/core/data/models/spot.dart';
import 'package:turismo_rural_frontend/core/data/models/user.dart';

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

class LoginSubmitSucess extends LoginState {
  final User user;
  final Set<Spot> spotsBusiness;
  const LoginSubmitSucess(this.user, this.spotsBusiness);

  @override
  List<Object> get props => [user];
}

class LoginError extends LoginState {
  final String error;

  const LoginError(this.error);

  @override
  List<Object> get props => [error];
}
