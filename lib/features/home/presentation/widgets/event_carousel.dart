import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turismo_rural_frontend/config/navigation_cubit.dart';
import 'package:turismo_rural_frontend/core/data/models/event.dart';
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
    final eventHeight = MediaQuery.of(context).size.height * 0.18;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          "Eventos",
          textAlign: TextAlign.left,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 8),
        CarouselSlider.builder(
          itemCount: events.length,
          itemBuilder: (BuildContext context, int index, int pageViewIndex) {
            final event = events.elementAt(index);
            return _buildItem(context, event, eventHeight);
          },
          options: CarouselOptions(
            height: eventHeight + 80,
            viewportFraction: 0.75,
            enableInfiniteScroll: false,
            enlargeCenterPage: true,
          ),
        ),
      ],
    );
  }

  Widget _buildItem(BuildContext context, Event event, double eventHeight) {
    return GestureDetector(
      onTap: () {
        context
            .read<NavigationCubit>()
            .navigateTo(appPage: AppPage.experiences, experience: event);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.75,
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
                  child: event.image != null
                      ? Image.network(
                          event.image!,
                          fit: BoxFit.cover,
                        )
                      : null,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text(
                event.name,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
