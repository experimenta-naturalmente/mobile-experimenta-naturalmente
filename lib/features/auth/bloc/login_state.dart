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

class LoginSubmitError extends LoginState {
  final String error;

  const LoginSubmitError(this.error);

  @override
  List<Object> get props => [error];
}

abstract class ProfileState extends LoginState {
  final User user;
  const ProfileState(this.user);

  @override
  List<Object> get props => [user];
}

class ProfileLoading extends ProfileState {
  const ProfileLoading(super.user);
}

class ProfileError extends ProfileState {
  final String error;

  const ProfileError(super.user, this.error);

  @override
  List<Object> get props => [error];
}

class ProfileSuccess extends ProfileState {
  final Set<Spot> spotsBusiness;

  const ProfileSuccess(super.user, this.spotsBusiness);

  @override
  List<Object> get props => [user, spotsBusiness];
}
