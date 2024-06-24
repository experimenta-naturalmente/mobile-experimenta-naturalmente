import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turismo_rural_frontend/core/data/models/user.dart';
import 'package:turismo_rural_frontend/core/widgets/backgrounds/double_circle.dart';
import 'package:turismo_rural_frontend/core/widgets/shared/error_handler.dart';
import 'package:turismo_rural_frontend/core/widgets/shared/loading_indicator.dart';
import 'package:turismo_rural_frontend/features/auth/bloc/login_bloc.dart';
import 'package:turismo_rural_frontend/features/auth/bloc/login_event.dart';
import 'package:turismo_rural_frontend/features/auth/bloc/login_state.dart';
import 'package:turismo_rural_frontend/features/auth/presentation/widgets/profile_tabbar.dart';

class UserProfileScreen extends StatelessWidget {
  final User user;

  const UserProfileScreen({required this.user});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        if (state is ProfileLoading) {
          return Stack(
            children: [
              DoubleCircle(),
              const LoadingIndicator(),
            ],
          );
        }
        if (state is ProfileError) {
          return ErrorHandler(
            error: state.error,
            onRetry: () {
              context.read<LoginBloc>().add(
                    LoginClear(),
                  );
            },
          );
        }
        if (state is ProfileSuccess) {
          final spotsBusiness = state.spotsBusiness;
          return Stack(
            children: [
              OverflowBox(child: DoubleCircle()),
              Column(
                children: [
                  const SizedBox(height: 8),
                  SizedBox(
                    height: screenHeight > 700
                        ? screenHeight * 0.2
                        : screenHeight * 0.15,
                    width: double.infinity,
                    child: CircleAvatar(
                      child: Image.asset('assets/logo/logo_small.png'),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                    alignment: AlignmentDirectional.center,
                    child: Text(
                      user.name,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Expanded(
                    child: ProfileTabbar(
                      user: user,
                      spotsBusiness: spotsBusiness,
                    ),
                  ),
                ],
              ),
            ],
          );
        }
        return Container();
      },
    );
  }
}
