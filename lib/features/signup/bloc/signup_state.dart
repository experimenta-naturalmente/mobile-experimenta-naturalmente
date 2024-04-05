import 'package:equatable/equatable.dart';

abstract class SignUpState extends Equatable {
  const SignUpState();

  @override
  List<Object> get props => [];
}

class SignUpInitial extends SignUpState {}

class SignUpError extends SignUpState {
  final String error;

  const SignUpError(this.error);

  @override
  List<Object> get props => [error];
}

class SignUpLoading extends SignUpState {}
