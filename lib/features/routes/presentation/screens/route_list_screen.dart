import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:turismo_rural_frontend/config/navigation_cubit.dart';
import 'package:turismo_rural_frontend/core/data/models/touristic_route.dart';
import 'package:turismo_rural_frontend/core/utils/enums.dart';
import 'package:turismo_rural_frontend/core/widgets/shared/empty_list.dart';
import 'package:turismo_rural_frontend/core/widgets/shared/faded_divider.dart';
import 'package:turismo_rural_frontend/core/widgets/shared/loading_indicator.dart';
import 'package:turismo_rural_frontend/features/routes/bloc/route_bloc.dart';
import 'package:turismo_rural_frontend/features/routes/bloc/route_event.dart';
import 'package:turismo_rural_frontend/features/routes/bloc/route_state.dart';

class RouteListScreen extends StatelessWidget {
  const RouteListScreen();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RouteBloc, RouteState>(
      builder: (BuildContext context, RouteState state) {
        if (state is RouteListInitial) {
          context.read<RouteBloc>().add(LoadRouteList());
        }
        if (state is RouteListLoading) {
          return const LoadingIndicator();
        }
        if (state is RouteListLoaded) {
          return _buildRoutesList(context, state.routes);
        }
        return Container();
      },
    );
  }

  Widget _buildRoutesList(BuildContext context, Set<TouristicRoute> routes) {
    final screenWidth = MediaQuery.of(context).size.width;
    if (routes.isEmpty) {
      return SizedBox(width: double.infinity, child: EmptyList());
    }
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: ListView.separated(
        itemCount: routes.length,
        separatorBuilder: (BuildContext context, int index) {
          return FadedDivider(
            width: screenWidth * 0.8,
          );
        },
        itemBuilder: (BuildContext context, int index) {
          final route = routes.elementAt(index);
          return _buildRouteItem(context, route);
        },
      ),
    );
  }

  Widget _buildRouteItem(BuildContext context, TouristicRoute route) {
    final screenHeight = MediaQuery.of(context).size.height;
    const minHeight = 100.0;
    final tileHeight = screenHeight > minHeight ? minHeight : screenHeight;

    return ListTile(
      titleAlignment: ListTileTitleAlignment.center,
      contentPadding: const EdgeInsets.all(8.0),
      title: Text(route.name),
      subtitle: Text(route.description),
      isThreeLine: true,
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(12.0),
        child: CachedNetworkImage(
          width: tileHeight * 0.7,
          height: tileHeight * 0.5,
          imageUrl: route.experienceList.firstOrNull?.image ??
              'https://picsum.photos/200/300?random=${route.experienceList.firstOrNull?.hashCode ?? 0}?blur',
          fit: BoxFit.cover,
          placeholder: (context, url) => const Icon(
            FontAwesome5.image,
            size: 48,
          ),
          errorWidget: (context, url, error) => Image.network(
            route.experienceList.firstOrNull?.image ??
                'https://picsum.photos/200/300?random=${route.experienceList.firstOrNull?.hashCode ?? 0}?blur',
            fit: BoxFit.cover,
            height: tileHeight * 0.5,
          ),
        ),
      ),
      onTap: () {
        context.read<NavigationCubit>().navigateTo(
              appPage: AppPage.routes,
              item: route,
            );
      },
    );
  }
}
