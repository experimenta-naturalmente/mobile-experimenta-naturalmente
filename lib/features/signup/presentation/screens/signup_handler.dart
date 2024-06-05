import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turismo_rural_frontend/core/widgets/shared/error_handler.dart';
import 'package:turismo_rural_frontend/core/widgets/shared/submit_button.dart';
import 'package:turismo_rural_frontend/features/signup/bloc/signup_bloc.dart';
import 'package:turismo_rural_frontend/features/signup/bloc/signup_event.dart';
import 'package:turismo_rural_frontend/features/signup/bloc/signup_state.dart';
import 'package:turismo_rural_frontend/features/signup/presentation/screens/signup_page_date_range.dart';
import 'package:turismo_rural_frontend/features/signup/presentation/screens/signup_page_description.dart';
import 'package:turismo_rural_frontend/features/signup/presentation/screens/signup_page_form.dart';
import 'package:turismo_rural_frontend/features/signup/presentation/screens/signup_page_initial.dart';
import 'package:turismo_rural_frontend/features/signup/presentation/screens/signup_page_tag_selection.dart';
import 'package:turismo_rural_frontend/features/signup/presentation/screens/signup_page_working_hours.dart';

class SignUpHandler extends StatelessWidget {
  const SignUpHandler({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpBloc, SignUpState>(
      builder: (BuildContext context, SignUpState state) {
        try {
          final showAdvance = state is! SignUpError && state is! SignUpLoading;
          final showBack = state is! SignUpPageInitialState && showAdvance;
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _getPage(context),
              Padding(
                padding: const EdgeInsets.all(12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Visibility(
                      visible: showBack,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        child: SubmitButton(
                          text: 'Voltar',
                          onPressed: () => context
                              .read<SignUpBloc>()
                              .add(const SignUpChangePage(previous: true)),
                        ),
                      ),
                    ),
                    Visibility(
                      visible: showAdvance,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        child: SubmitButton(
                          text: 'Avançar',
                          onPressed: () => context
                              .read<SignUpBloc>()
                              .add(const SignUpChangePage()),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        } catch (e) {
          context.read<SignUpBloc>().add(const SignUpErrorEvent());
          return Container();
        }
      },
    );
  }

  Widget _getPage(BuildContext context) {
    final state = context.read<SignUpBloc>().state;
    if (state is SignUpError) {
      return const ErrorHandler();
    }
    if (state is SignUpLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    if (state is SignUpPageInitialState) {
      return const SignUpPageInitial();
    }
    if (state is SignUpPageDescriptionState) {
      return SignUpPageDescription(
        state: state,
      );
    }
    if (state is SignUpPageFormState) {
      return SignUpPageForm();
    }
    if (state is SignUpPageDateRangeState) {
      return const SignUpPageDateRange();
    }
    if (state is SignUpPageWorkingHoursState) {
      return SignUpPageWorkingHours(
        state: state,
      );
    }
    if (state is SignUpPageTagSelectionState) {
      return SignUpTagSelection(
        state: state,
      );
    }
    return Container();
  }
}
