import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turismo_rural_frontend/features/signup/bloc/signup_bloc/signup_event.dart';
import 'package:turismo_rural_frontend/features/signup/bloc/signup_bloc/signup_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  // na declaração do bloc, cada evento é associado a uma função
  SignUpBloc() : super(SignUpInitial()) {
    on<SignUpNextPage>(_onSignUpNextPage);
  }

  Future<void> _onSignUpNextPage(
    SignUpNextPage event,
    Emitter<SignUpState> emit,
  ) async {
    print("aaaa");
  }
}
