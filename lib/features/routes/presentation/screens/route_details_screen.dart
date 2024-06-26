import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turismo_rural_frontend/core/widgets/shared/faded_divider.dart';
import 'package:turismo_rural_frontend/core/widgets/shared/loading_indicator.dart';
import 'package:turismo_rural_frontend/features/routes/bloc/route_bloc.dart';
import 'package:turismo_rural_frontend/features/routes/bloc/route_event.dart';
import 'package:turismo_rural_frontend/features/routes/bloc/route_state.dart';
import 'package:turismo_rural_frontend/features/routes/presentation/widgets/route_details_carousel.dart';
import 'package:turismo_rural_frontend/features/routes/presentation/widgets/route_details_header.dart';

class RouteDetailsScreen extends StatelessWidget {
  const RouteDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return BlocBuilder<RouteBloc, RouteState>(
      builder: (BuildContext context, RouteState state) {
        if (state is RouteDetailsInitial) {
          context.read<RouteBloc>().add(LoadRouteDetails(state.routeId));
        }
        if (state is RouteDetailsLoading) {
          return const LoadingIndicator();
        }
        if (state is RouteDetailsLoaded) {
          final route = state.route;
          return SingleChildScrollView(
            child: Column(
              children: <Widget>[
                RouteDetailsHeader(route: route),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: FadedDivider(width: screenWidth * 0.9),
                ),
                RouteDetailsCarousel(
                  routeItemList: route.experienceList,
                ),
              ],
            ),
          );
        }
        return Container();
      },
    );
  }
}
