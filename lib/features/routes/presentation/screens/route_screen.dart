import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turismo_rural_frontend/core/widgets/backgrounds/double_circle.dart';
import 'package:turismo_rural_frontend/core/widgets/shared/error_handler.dart';
import 'package:turismo_rural_frontend/features/routes/bloc/route_bloc.dart';
import 'package:turismo_rural_frontend/features/routes/bloc/route_event.dart';
import 'package:turismo_rural_frontend/features/routes/bloc/route_state.dart';
import 'package:turismo_rural_frontend/features/routes/presentation/screens/route_details_screen.dart';
import 'package:turismo_rural_frontend/features/routes/presentation/screens/route_list_screen.dart';

class RouteScreen extends StatelessWidget {
  const RouteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RouteBloc, RouteState>(
      builder: (context, state) {
        if (state is RouteError) {
          return ErrorHandler(
            error: state.error,
            onRetry: () => context.read<RouteBloc>().add(
                  LoadRouteList(),
                ),
          );
        }
        if (state is RouteListState) {
          return Stack(
            children: [
              DoubleCircle(),
              const RouteListScreen(),
            ],
          );
        }
        if (state is RouteDetailsState) {
          return Stack(
            children: [
              DoubleCircle(),
              const RouteDetailsScreen(),
            ],
          );
        }
        return Container();
      },
    );
  }
}
