import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turismo_rural_frontend/core/data/models/experience.dart';
import 'package:turismo_rural_frontend/core/widgets/backgrounds/double_circle.dart';
import 'package:turismo_rural_frontend/core/widgets/shared/error_handler.dart';
import 'package:turismo_rural_frontend/core/widgets/shared/loading_indicator.dart';
import 'package:turismo_rural_frontend/features/home/bloc/home_bloc.dart';
import 'package:turismo_rural_frontend/features/home/bloc/home_state.dart';
import 'package:turismo_rural_frontend/features/home/presentation/widgets/event_list_item.dart';
import 'package:turismo_rural_frontend/features/home/presentation/widgets/spot_list_item.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (BuildContext context, HomeState state) {
        if (state is HomeLoading) {
          return const LoadingIndicator();
        }
        if (state is HomeError) {
          return ErrorHandler(
            error: state.error,
            onRetry: () => {},
          );
        }
        if (state is HomeLoaded) {
          return Stack(
            children: [
              DoubleCircle(),
              Column(
                children: [
                  _buildEventsList(state.events),
                  _buildSpotsList(state.spots),
                  const LoadingIndicator(),
                ],
              ),
            ],
          );
        }
        return Container();
      },
    );
  }

  Widget _buildEventsList(Set<Experience> experiences) {
    return Wrap(
      children: <Widget>[
        const Padding(
          padding: EdgeInsets.only(left: 24.0),
          child: Text(
            "Eventos",
            textAlign: TextAlign.left,
            style: TextStyle(
              fontSize: 24,
            ),
          ),
        ),
        Builder(
          builder: (BuildContext context) {
            return SizedBox(
              height: 175.0,
              width: MediaQuery.of(context).size.width,
              child: Stack(
                children: [
                  Positioned(
                    left: 0,
                    right: -150,
                    top: 0,
                    bottom: 0,
                    child: CarouselSlider.builder(
                      itemCount: experiences.length,
                      itemBuilder:
                          (BuildContext context, int index, int pageViewIndex) {
                        final experience = experiences.elementAt(index);
                        return EventListItem(
                            event: experience, onTap: () => {});
                      },
                      options: CarouselOptions(
                        height: 400,
                        viewportFraction: 0.55,
                        padEnds: false,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildSpotsList(Set<Experience> experiences) {
    return ListView.builder(
      itemCount: experiences.length,
      itemBuilder: (BuildContext context, int index) {
        final experience = experiences.elementAt(index);
        return SpotListItem(spot: experience, onTap: () => {});
      },
    );
  }
}
