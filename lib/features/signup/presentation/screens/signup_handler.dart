import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turismo_rural_frontend/core/widgets/shared/submit_button.dart';
import 'package:turismo_rural_frontend/features/signup/bloc/signup_bloc/signup_bloc.dart';
import 'package:turismo_rural_frontend/features/signup/bloc/signup_bloc/signup_event.dart';
import 'package:turismo_rural_frontend/features/signup/bloc/signup_bloc/signup_state.dart';
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
        final showBack =
            state is! SignUpPageInitialState && state is! SignUpLoading;
        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(child: _getPage(state)),
            Expanded(
              flex: 0,
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (showBack)
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        child: SizedBox(
                          child: SubmitButton(
                            text: 'Voltar',
                            onPressed: () => context
                                .read<SignUpBloc>()
                                .add(const SignUpChangePage(previous: true)),
                          ),
                        ),
                      )
                    else
                      Container(),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      child: SizedBox(
                        width: showBack ? null : 240,
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
            ),
          ],
        );
      },
    );
  }

  Widget _getPage(SignUpState state) {
    if (state is SignUpError) {
      return Container();
    }
    if (state is SignUpLoading) {
      return Container();
    }
    if (state is SignUpPageInitialState) {
      return const SignUpPageInitial();
    }
    if (state is SignUpPageDescriptionState) {
      return const SignUpPageDescription();
    }
    if (state is SignUpPageFormState) {
      return SignUpPageForm();
    }
    if (state is SignUpPageWorkingHoursState) {
      return const SignUpPageWorkingHours();
    }
    if (state is SignUpPageTagSelectionState) {
      return SignUpTagSelection(
        state: state,
      );
    }
    return Container();
  }
}
