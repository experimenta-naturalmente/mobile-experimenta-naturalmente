import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:turismo_rural_frontend/core/utils/enums.dart';
import 'package:turismo_rural_frontend/features/signup/data/attachment.dart';

abstract class SignUpState extends Equatable {
  const SignUpState();

  @override
  List<Object> get props => [];
}

class SignUpPageInitialState extends SignUpState {}

class SignUpPageDescriptionState extends SignUpState {
  final List<AttachmentUpload> attachments;

  const SignUpPageDescriptionState({this.attachments = const []});

  @override
  List<Object> get props => [attachments];

  SignUpPageDescriptionState copyWith({
    List<AttachmentUpload>? attachments,
  }) {
    return SignUpPageDescriptionState(
      attachments: attachments ?? this.attachments,
    );
  }
}

class SignUpPageFormState extends SignUpState {}

class SignUpPageWorkingHoursState extends SignUpState {
  final Map<WeekDay, List<(TimeOfDay, TimeOfDay)>> workingHours;

  const SignUpPageWorkingHoursState({required this.workingHours});

  @override
  List<Object> get props => [...workingHours.entries];
}

class SignUpPageDateRangeState extends SignUpState {
  final ValueNotifier<DateTime?> startDate;
  final ValueNotifier<DateTime?> endDate;

  SignUpPageDateRangeState()
      : startDate = ValueNotifier<DateTime?>(null),
        endDate = ValueNotifier<DateTime?>(null);

  bool get canProceed => startDate.value != null && endDate.value != null;

  @override
  List<Object> get props => [startDate, endDate];
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

class SignUpSuccess extends SignUpState {}

class SignUpError extends SignUpState {
  final String? error;

  const SignUpError({this.error});
}

class SignUpLoading extends SignUpState {}
