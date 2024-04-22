import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class SignUpState extends Equatable {
  const SignUpState();

  @override
  List<Object> get props => [];
}

class SignUpPageInitialState extends SignUpState {}

class SignUpPageDescriptionState extends SignUpState {}

class SignUpPageFormState extends SignUpState {}

class SignUpPageWorkingHoursState extends SignUpState {
  static const segundaFeira = 'Segunda-feira';
  static const tercaFeira = 'Terca-feira';
  static const quartaFeira = 'Quarta-feira';
  static const quintaFeira = 'Quinta-feira';
  static const sextaFeira = 'Sexta-feira';
  static const sabado = 'Sábado';
  static const domingo = 'Domingo';
  static const feriados = 'Feriados';

  final Map<String, ValueNotifier<bool>> checkboxNotifier;

  SignUpPageWorkingHoursState()
      : checkboxNotifier = {
          segundaFeira: ValueNotifier<bool>(false),
          tercaFeira: ValueNotifier<bool>(false),
          quartaFeira: ValueNotifier<bool>(false),
          quintaFeira: ValueNotifier<bool>(false),
          sextaFeira: ValueNotifier<bool>(false),
          sabado: ValueNotifier<bool>(false),
          domingo: ValueNotifier<bool>(false),
          feriados: ValueNotifier<bool>(false),
        };

  bool get canProceed => checkboxNotifier.values
      .any((valueNotifier) => valueNotifier.value == true);

  @override
  List<Object> get props => [checkboxNotifier];
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
