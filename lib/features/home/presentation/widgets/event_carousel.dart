import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turismo_rural_frontend/config/navigation_cubit.dart';
import 'package:turismo_rural_frontend/core/data/models/event.dart';
import 'package:turismo_rural_frontend/core/utils/common.dart';
import 'package:turismo_rural_frontend/core/utils/enums.dart';
import 'package:turismo_rural_frontend/features/home/bloc/home_bloc.dart';
import 'package:turismo_rural_frontend/features/home/bloc/home_state.dart';

class EventCarousel extends StatelessWidget {
  const EventCarousel({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    if (context.watch<HomeBloc>().state is! HomeLoaded) {
      return const SizedBox();
    }
    final state = context.watch<HomeBloc>().state as HomeLoaded;
    final categories = state.spotCategories;
    if (categories.isEmpty) {
      return const SizedBox();
    }
    final events = state.featuredEvents;

    return _buildCarousel(context, events);
  }

  Widget _buildCarousel(BuildContext context, Set<Event> events) {
    final orientation = MediaQuery.of(context).orientation;
    final screenHeight = MediaQuery.of(context).size.height;
    final eventHeight = orientation == Orientation.portrait
        ? screenHeight * 0.22
        : screenHeight * 0.5;
    final screenWidth = MediaQuery.of(context).size.width;
    final eventWidth = eventHeight * 16 / 9;
    if (events.isEmpty) {
      return const SizedBox();
    }
    final textTheme = screenWidth > 600
        ? Theme.of(context).textTheme.headlineMedium
        : Theme.of(context).textTheme.headlineSmall;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.05,
          ),
          child: Row(
            children: [
              RichText(
                text: TextSpan(
                  style: textTheme,
                  children: [
                    WidgetSpan(
                      alignment: PlaceholderAlignment.middle,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 2, right: 4),
                        child: iconFromCategory(
                          experienceCategory: events.first.category,
                          color: textTheme!.color,
                          size: screenWidth > 600 ? 28 : 24,
                        ),
                      ),
                    ),
                    const TextSpan(
                      text: "Eventos",
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        ShaderMask(
          shaderCallback: (Rect rect) {
            return LinearGradient(
              colors: [
                Colors.transparent,
                Theme.of(context).colorScheme.surface,
                Theme.of(context).colorScheme.surface,
                Colors.transparent,
              ],
              stops: const [0.0, 0.1, 0.9, 1.0],
            ).createShader(rect);
          },
          blendMode: BlendMode.dstIn,
          child: CarouselSlider.builder(
            itemCount: events.length,
            itemBuilder: (BuildContext context, int index, int pageViewIndex) {
              final event = events.elementAt(index);
              return Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: MediaQuery.of(context).size.width * 0.01,
                ),
                child: OverflowBox(
                  maxHeight: double.infinity,
                  maxWidth: double.infinity,
                  child: _buildItem(context, event, eventHeight, eventWidth),
                ),
              );
            },
            options: CarouselOptions(
              height: eventHeight * 1.1 + 60,
              viewportFraction: eventWidth / MediaQuery.of(context).size.width,
              enlargeCenterPage: true,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildItem(
    BuildContext context,
    Event event,
    double eventHeight,
    double eventWidth,
  ) {
    return GestureDetector(
      onTap: () {
        context
            .read<NavigationCubit>()
            .navigateTo(appPage: AppPage.experiences, item: event);
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: eventWidth,
            height: eventHeight,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: Theme.of(context).colorScheme.outline,
                width: 2,
              ),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: CachedNetworkImage(
                width: double.infinity,
                imageUrl: event.attachments.firstOrNull?.url ?? '',
                fit: BoxFit.cover,
                placeholder: (context, url) => const Center(
                  child: CircularProgressIndicator(),
                ),
                errorWidget: (context, url, error) => Image.network(
                  event.attachments.firstOrNull?.url ?? '',
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          SizedBox(height: eventHeight * 0.04),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Center(
              child: Text(
                event.name,
                style: Theme.of(context).textTheme.titleMedium,
                textAlign: TextAlign.center,
                softWrap: true,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
