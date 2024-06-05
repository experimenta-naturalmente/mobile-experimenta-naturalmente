import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turismo_rural_frontend/core/data/models/experience_category.dart';
import 'package:turismo_rural_frontend/core/data/models/spot.dart';
import 'package:turismo_rural_frontend/features/home/bloc/home_bloc.dart';
import 'package:turismo_rural_frontend/features/home/bloc/home_state.dart';

class SpotsList extends StatelessWidget {
  const SpotsList({super.key});

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
    final spots = state.featuredSpots;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          "Spots",
          style: Theme.of(context).textTheme.titleLarge,
          textAlign: TextAlign.start,
        ),
        for (final category in categories) ...[
          _buildSpotsGroup(context, category, spots),
          const SizedBox(height: 20),
        ],
      ],
    );
  }

  Widget _buildSpotsGroup(
    BuildContext context,
    ExperienceCategory category,
    Set<Spot> spots,
  ) {
    final categorySpots = spots
        .where((spot) => spot.category.categoryId == category.categoryId)
        .toList();
    final cardHeight = MediaQuery.of(context).size.height * 0.12;
    final cardWidth = MediaQuery.of(context).size.width / 1.8 - 25;
    final spotsRows = categorySpots.length > 1 ? 2 : 1;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          category.name,
          style: Theme.of(context).textTheme.titleMedium,
          textAlign: TextAlign.start,
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: cardHeight * spotsRows + 20,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Wrap(
              direction: Axis.vertical,
              children: categorySpots.map((spot) {
                return _buildSpotCard(context, spot, cardHeight, cardWidth);
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSpotCard(
    BuildContext context,
    Spot spot,
    double cardHeight,
    double cardWidth,
  ) {
    return SizedBox(
      width: cardWidth,
      height: cardHeight,
      child: Card(
        child: Row(
          children: [
            Padding(
              padding: EdgeInsets.only(
                top: cardHeight * 0.05,
                bottom: cardHeight * 0.05,
                left: cardHeight * 0.1,
              ),
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Theme.of(context).colorScheme.tertiary,
                    width: 2.0,
                  ),
                ),
                child: ClipOval(
                  child: CachedNetworkImage(
                    imageUrl: spot.image ??
                        spot.images.firstOrNull ??
                        'https://picsum.photos/200/300?random=${spot.id}?blur',
                    fit: BoxFit.cover,
                    width: cardHeight * 0.7,
                    height: cardHeight * 0.7,
                    placeholder: (context, url) =>
                        const CircularProgressIndicator(),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8.0),
            Flexible(
              flex: 2,
              child: Text(
                spot.name,
                style: Theme.of(context).textTheme.labelLarge,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
