import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turismo_rural_frontend/features/signup/bloc/signup_bloc/color_event.dart';
import 'package:turismo_rural_frontend/features/signup/bloc/signup_bloc/color_state.dart';

class ColorBloc extends Bloc<ColorEvent, ColorState> {
  ColorBloc() : super(ColorState({})) {
    on<ChangeColor>((event, emit) {
      final newColorStatus = Map<String, Color>.from(state.colorStatus);
      newColorStatus[event.text] = event.color;

      emit(ColorState(newColorStatus));
    });
  }
}
