import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:turismo_rural_frontend/config/navigation_cubit.dart';
import 'package:turismo_rural_frontend/core/data/models/touristic_route.dart';
import 'package:turismo_rural_frontend/core/utils/enums.dart';
import 'package:turismo_rural_frontend/features/home/bloc/home_bloc.dart';
import 'package:turismo_rural_frontend/features/home/bloc/home_state.dart';

class RoutesList extends StatelessWidget {
  const RoutesList({super.key});

  @override
  Widget build(BuildContext context) {
    if (context.watch<HomeBloc>().state is! HomeLoaded) {
      return const SizedBox();
    }
    final state = context.watch<HomeBloc>().state as HomeLoaded;
    final routes = state.featuredRoutes;
    final orientation = MediaQuery.of(context).orientation;

    if (orientation == Orientation.portrait) {
      return SizedBox(
        width: double.infinity,
        child: _buildPortraitRoutesGroup(context, routes),
      );
    }

    return SizedBox(
      width: double.infinity,
      child: _buildLandscapeRoutesGroup(context, routes),
    );
  }

  Widget _buildPortraitRoutesGroup(
    BuildContext context,
    Set<TouristicRoute> routes,
  ) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    final cardHeight = screenHeight * 0.25;
    final cardWidth = screenWidth * 0.9;
    const maxCardWidth = 500.0;
    final adjustedCardWidth =
        cardWidth < maxCardWidth ? cardWidth : maxCardWidth;

    final routesRows = routes.length > 1 && screenHeight > 500 ? 2 : 1;
    final textTheme = screenWidth > 600
        ? Theme.of(context).textTheme.headlineMedium
        : Theme.of(context).textTheme.headlineSmall;

    final scrolls = routes.length > 2;
    final fadeStops = scrolls ? [0.0, 0.9, 1.0] : [0.0, 1.0, 1.0];

    final ScrollController scrollController = ScrollController();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: screenWidth * 0.07, top: 18),
          child: RichText(
            text: TextSpan(
              style: textTheme,
              children: [
                WidgetSpan(
                  alignment: PlaceholderAlignment.middle,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 2, right: 12),
                    child: Icon(
                      FontAwesome5.map_marked_alt,
                      color: textTheme!.color,
                      size: screenWidth > 600 ? 28 : 24,
                    ),
                  ),
                ),
                const TextSpan(
                  text: 'Rotas Turísticas',
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 10),
        ShaderMask(
          shaderCallback: (Rect bounds) {
            return LinearGradient(
              colors: [
                Theme.of(context).scaffoldBackgroundColor,
                Theme.of(context).scaffoldBackgroundColor,
                Colors.transparent,
              ],
              stops: fadeStops,
            ).createShader(bounds);
          },
          blendMode: BlendMode.dstIn,
          child: SizedBox(
            height: cardHeight * routesRows + 8,
            child: Scrollbar(
              controller: scrollController,
              child: Padding(
                padding: const EdgeInsets.  only(bottom: 8.0, left: 8.0),
                child: SingleChildScrollView(
                  controller: scrollController,
                  scrollDirection: Axis.horizontal,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: Wrap(
                      direction: Axis.vertical,
                      children: routes.map((route) {
                        return _buildRouteCard(
                          context,
                          route,
                          cardHeight,
                          adjustedCardWidth,
                          4.0,
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLandscapeRoutesGroup(
    BuildContext context,
    Set<TouristicRoute> routes,
  ) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    final cardHeight = screenHeight * 0.25;
    const minHeight = 150.0;
    final adjustedCardHeight = cardHeight > minHeight ? cardHeight : minHeight;
    final cardWidth = screenWidth * 0.6;
    const maxCardWidth = 400.0;
    final adjustedCardWidth =
        cardWidth < maxCardWidth ? cardWidth : maxCardWidth;

    final routesRows = routes.length > 1 && screenHeight > 500 ? 2 : 1;
    final textTheme = screenWidth > 600
        ? Theme.of(context).textTheme.headlineMedium
        : Theme.of(context).textTheme.headlineSmall;

    final scrolls = screenWidth / adjustedCardWidth < routes.length / 2;
    final fadeStops = scrolls ? [0.0, 0.9, 1.0] : [0.0, 1.0, 1.0];

    final ScrollController scrollController = ScrollController();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: screenWidth * 0.07, top: 18),
          child: RichText(
            text: TextSpan(
              style: textTheme,
              children: [
                WidgetSpan(
                  alignment: PlaceholderAlignment.middle,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 2, right: 12),
                    child: Icon(
                      FontAwesome5.map_marked_alt,
                      color: textTheme!.color,
                      size: screenWidth > 600 ? 28 : 24,
                    ),
                  ),
                ),
                const TextSpan(
                  text: 'Rotas Turísticas',
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 10),
        ShaderMask(
          shaderCallback: (Rect bounds) {
            return LinearGradient(
              colors: [
                Theme.of(context).scaffoldBackgroundColor,
                Theme.of(context).scaffoldBackgroundColor,
                Colors.transparent,
              ],
              stops: fadeStops,
            ).createShader(bounds);
          },
          blendMode: BlendMode.dstIn,
          child: SizedBox(
            height: adjustedCardHeight * routesRows + 8,
            child: Scrollbar(
              controller: scrollController,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: SingleChildScrollView(
                  controller: scrollController,
                  scrollDirection: Axis.horizontal,
                  child: Wrap(
                    direction: Axis.vertical,
                    children: routes.map((route) {
                      return _buildRouteCard(
                        context,
                        route,
                        adjustedCardHeight,
                        adjustedCardWidth,
                        8.0,
                      );
                    }).toList(),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildRouteCard(
    BuildContext context,
    TouristicRoute route,
    double cardHeight,
    double cardWidth,
    double margin,
  ) {
    return GestureDetector(
      onTap: () {
        context
            .read<NavigationCubit>()
            .navigateTo(appPage: AppPage.routes, item: route);
      },
      child: SizedBox(
        width: cardWidth,
        height: cardHeight,
        child: Card.filled(
          margin: EdgeInsets.all(margin),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    top: cardHeight * 0.05,
                    bottom: cardHeight * 0.05,
                    left: cardWidth * 0.01,
                  ),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        width: cardHeight * 0.7,
                        height: cardHeight * 0.7,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Theme.of(context).colorScheme.tertiary,
                            width: 2.0,
                          ),
                          borderRadius: BorderRadius.circular(26.0),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(24.0),
                          child: CachedNetworkImage(
                            imageUrl: route.experienceList.firstOrNull?.image ??
                                'https://picsum.photos/200/300?random=${route.experienceList.firstOrNull?.hashCode ?? 0}?blur',
                            width: cardHeight * 0.7,
                            height: cardHeight * 0.7,
                            fit: BoxFit.cover,
                            placeholder: (context, url) => const Icon(
                              FontAwesome5.image,
                              size: 48,
                            ),
                            errorWidget: (context, url, error) => Image.network(
                              route.experienceList.firstOrNull?.image ??
                                  'https://picsum.photos/200/300?random=${route.experienceList.firstOrNull?.hashCode ?? 0}?blur',
                              width: cardHeight * 0.7,
                              height: cardHeight * 0.7,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: cardWidth * 0.05),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: Text(
                          route.name,
                          style: route.name.length > 20
                              ? Theme.of(context).textTheme.titleSmall
                              : Theme.of(context).textTheme.titleMedium,
                          softWrap: true,
                        ),
                      ),
                      SizedBox(height: cardHeight * 0.02),
                      Text(
                        route.description,
                        style: Theme.of(context).textTheme.bodySmall,
                        overflow: TextOverflow.fade,
                        textAlign: TextAlign.left,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
