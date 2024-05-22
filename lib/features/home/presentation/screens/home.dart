import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turismo_rural_frontend/core/widgets/shared/error_handler.dart';
import 'package:turismo_rural_frontend/features/home/bloc/home_bloc.dart';
import 'package:turismo_rural_frontend/features/home/bloc/home_event.dart';
import 'package:turismo_rural_frontend/features/home/bloc/home_state.dart';
import 'package:turismo_rural_frontend/features/home/presentation/widgets/event_carousel.dart';
import 'package:turismo_rural_frontend/features/home/presentation/widgets/home_header.dart';
import 'package:turismo_rural_frontend/features/home/presentation/widgets/spot_list.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
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
          return Column(
            children: [
              SizedBox(
                height: screenHeight * 0.05,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                child: HomeHeader(),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      _buildTouristRoutes(context),
                      const EventCarousel(),
                      const SpotList(),
                    ],
                  ),
                ),
              ),
            ],
          );
        }
        return const SizedBox();
      },
    );
  }

  Widget _buildTouristRoutes(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Rotas Turísticas",
          style: Theme.of(context).textTheme.titleLarge,
          textAlign: TextAlign.start,
        ),
        Container(
          height: 200,
          decoration: BoxDecoration(
            color: Colors.white54,
            border: Border.all(),
          ),
        ),
      ],
    );
  }
}
