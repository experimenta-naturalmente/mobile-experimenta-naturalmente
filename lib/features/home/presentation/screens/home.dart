import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turismo_rural_frontend/core/widgets/backgrounds/double_circle.dart';
import 'package:turismo_rural_frontend/core/widgets/shared/error_handler.dart';
import 'package:turismo_rural_frontend/core/widgets/shared/faded_divider.dart';
import 'package:turismo_rural_frontend/features/home/bloc/home_bloc.dart';
import 'package:turismo_rural_frontend/features/home/bloc/home_event.dart';
import 'package:turismo_rural_frontend/features/home/bloc/home_state.dart';
import 'package:turismo_rural_frontend/features/home/presentation/widgets/event_carousel.dart';
import 'package:turismo_rural_frontend/features/home/presentation/widgets/home_header.dart';
import 'package:turismo_rural_frontend/features/home/presentation/widgets/routes_list.dart';
import 'package:turismo_rural_frontend/features/home/presentation/widgets/spots_list.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        if (state is HomeInitial) {
          context.read<HomeBloc>().add(HomeLoadData());
        }
        if (state is HomeLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is HomeError) {
          return Center(
            child: ErrorHandler(
              error: state.error,
              onRetry: () => context.read<HomeBloc>().add(
                    HomeLoadData(),
                  ),
            ),
          );
        }
        if (state is HomeLoaded) {
          return Stack(
            children: [
              DoubleCircle(),
              if (isLandscape)
                _buildLandscapeLayout(
                  context,
                  screenWidth,
                  screenHeight,
                )
              else
                _buildPortraitLayout(
                  context,
                  screenWidth,
                  screenHeight,
                ),
            ],
          );
        }
        return const SizedBox();
      },
    );
  }

  Widget _buildPortraitLayout(
    BuildContext context,
    double screenWidth,
    double screenHeight,
  ) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const HomeHeader(),
          const SizedBox(height: 16),
          const EventCarousel(),
          Center(
            child: SizedBox(
              width: screenWidth * 0.8,
              child: const FadedDivider(),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 6.0),
            child: SpotsList(),
          ),
          Center(
            child: SizedBox(
              width: screenWidth * 0.8,
              child: const FadedDivider(),
            ),
          ),
          const RoutesList(),
        ],
      ),
    );
  }

  Widget _buildLandscapeLayout(
    BuildContext context,
    double screenWidth,
    double screenHeight,
  ) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const HomeHeader(),
          Column(
            children: [
              SizedBox(height: screenHeight * 0.03),
              const EventCarousel(),
              Center(
                child: SizedBox(
                  width: screenWidth * 0.8,
                  child: const FadedDivider(),
                ),
              ),
              const RoutesList(),
              Center(
                child: SizedBox(
                  width: screenWidth * 0.8,
                  child: const FadedDivider(),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: 12,
                  top: screenHeight * 0.02,
                  bottom: screenHeight * 0.02,
                ),
                child: const SpotsList(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
