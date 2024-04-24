import 'package:equatable/equatable.dart';

abstract class SignUpState extends Equatable {
  const SignUpState();

  @override
  List<Object> get props => [];
}

class SignUpPageInitialState extends SignUpState {}

class SignUpPageDescriptionState extends SignUpState {}

class SignUpPageFormState extends SignUpState {}

class SignUpPageWorkingHoursState extends SignUpState {}

class SignUpPageTagSelectionState extends SignUpState {
  final Map<int, bool> selectedTags;

  const SignUpPageTagSelectionState({
    required this.selectedTags,
  });

  @override
  List<Object> get props => [selectedTags];

  SignUpPageTagSelectionState copyWith({
    required Map<int, bool> selectedTags,
  }) {
    return SignUpPageTagSelectionState(
      selectedTags: selectedTags,
    );
  }
}

class SignUpError extends SignUpState {
  final String error;

  const SignUpError(this.error);

  @override
  List<Object> get props => [error];
}

class SignUpLoading extends SignUpState {}
