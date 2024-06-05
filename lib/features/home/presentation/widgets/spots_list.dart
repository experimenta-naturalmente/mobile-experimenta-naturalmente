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

    return SingleChildScrollView(
      physics: const RangeMaintainingScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.only(left: 12, right: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
        ),
      ),
    );
  }

  Widget _buildSpotsGroup(
    BuildContext context,
    ExperienceCategory category,
    Set<Spot> spots,
  ) {
    final categorySpots =
        spots.where((spot) => spot.category.id == category.id).toList();
    final cardHeight = MediaQuery.of(context).size.height * 0.12;
    final cardWidth = MediaQuery.of(context).size.width / 2 - 25;

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
          height: cardHeight * 2 + 20,
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
      child: Card.outlined(
        child: Row(
          children: [
            Expanded(
              child: Padding(
                padding:
                    EdgeInsets.only(left: cardHeight * 0.05, top: 4, bottom: 4),
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(12.0)),
                  child: spot.image != null
                      ? Image.network(
                          spot.image!,
                          fit: BoxFit.cover,
                        )
                      : null,
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
