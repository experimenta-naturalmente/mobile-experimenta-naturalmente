import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:turismo_rural_frontend/core/data/models/experience_category.dart';
import 'package:turismo_rural_frontend/core/utils/enums.dart';

abstract class SignUpState extends Equatable {
  const SignUpState();

  @override
  List<Object> get props => [];
}

class SignUpPageInitialState extends SignUpState {}

class SignUpPageDescriptionState extends SignUpState {}

class SignUpPageFormState extends SignUpState {}

class SignUpPageWorkingHoursState extends SignUpState {
  final Map<WeekDay, List<(TimeOfDay, TimeOfDay)>> workingHours;

  const SignUpPageWorkingHoursState({required this.workingHours});

  @override
  List<Object> get props => [...workingHours.entries];
}

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
