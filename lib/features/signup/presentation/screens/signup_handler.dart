import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turismo_rural_frontend/config/navigation_cubit.dart';
import 'package:turismo_rural_frontend/core/utils/enums.dart';
import 'package:turismo_rural_frontend/core/widgets/shared/error_handler.dart';
import 'package:turismo_rural_frontend/core/widgets/shared/submit_button.dart';
import 'package:turismo_rural_frontend/features/signup/bloc/signup_bloc.dart';
import 'package:turismo_rural_frontend/features/signup/bloc/signup_event.dart';
import 'package:turismo_rural_frontend/features/signup/bloc/signup_state.dart';
import 'package:turismo_rural_frontend/features/signup/presentation/screens/signup_page_date_range.dart';
import 'package:turismo_rural_frontend/features/signup/presentation/screens/signup_page_description.dart';
import 'package:turismo_rural_frontend/features/signup/presentation/screens/signup_page_finish.dart';
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
          final minHeight = MediaQuery.of(context).size.height * 0.75;
          return Scrollbar(
            thumbVisibility: true,
            child: SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: minHeight),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _getPage(context, state),
                    _buildNavigationButtons(context, state),
                  ],
                ),
              ),
            ),
          );
        } catch (e) {
          context.read<SignUpBloc>().add(const SignUpErrorEvent());
          return Container();
        }
      },
    );
  }

  Widget _getPage(BuildContext context, SignUpState state) {
    if (state is SignUpError) {
      return const ErrorHandler();
    } else if (state is SignUpLoading) {
      return const Center(child: CircularProgressIndicator());
    } else if (state is SignUpPageInitialState) {
      return const SignUpPageInitial();
    } else if (state is SignUpPageDescriptionState) {
      return SignUpPageDescription(state: state);
    } else if (state is SignUpPageFormState) {
      return SignUpPageForm();
    } else if (state is SignUpPageDateRangeState) {
      return const SignUpPageDateRange();
    } else if (state is SignUpPageWorkingHoursState) {
      return SignUpPageWorkingHours(state: state);
    } else if (state is SignUpPageTagSelectionState) {
      return SignUpTagSelection(
        tagRepository: context.read<SignUpBloc>().tagRepository,
        state: state,
      );
    } else if (state is SignUpSuccess) {
      return const SignUpPageFinish();
    }
    if (state is SignUpSuccess) {
      return const SignUpPageFinish();
    }
    return Container();
  }

  Widget _buildNavigationButtons(BuildContext context, SignUpState state) {
    final success = state is SignUpSuccess;
    final showAdvance = state is! SignUpError && state is! SignUpLoading;
    final showBack = state is! SignUpPageInitialState && showAdvance;
    final isDone = state is SignUpPageTagSelectionState;

    return Padding(
      padding: const EdgeInsets.all(12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Visibility(
            visible: showBack,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: SubmitButton(
                text: 'Voltar',
                onPressed: () => _handleBackButtonPressed(context, success),
              ),
            ),
          ),
          Visibility(
            visible: showAdvance && !success,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: SubmitButton(
                text: isDone ? 'Finalizar' : 'Avançar',
                onPressed: () =>
                    context.read<SignUpBloc>().add(const SignUpChangePage()),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _handleBackButtonPressed(BuildContext context, bool success) {
    if (success) {
      context.read<SignUpBloc>().add(LoadSignUp());
      context.read<NavigationCubit>().navigateTo(appPage: AppPage.home);
    } else {
      context.read<SignUpBloc>().add(const SignUpChangePage(previous: true));
    }
  }
}
