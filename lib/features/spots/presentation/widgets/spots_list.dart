import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turismo_rural_frontend/core/data/models/experience_category.dart';
import 'package:turismo_rural_frontend/features/experiences/presentation/view_models/experience_list_item.dart';
import 'package:turismo_rural_frontend/features/spots/bloc/spots_bloc.dart';

class SpotsList extends StatelessWidget {
  const SpotsList({super.key});

  @override
  Widget build(BuildContext context) {
    final categories = context.read<SpotsBloc>().categoriesCache;
    final experienceListMap =
        {}.cast<ExperienceCategory, Set<ExperienceListItem>>();

    return SingleChildScrollView(
      physics: const RangeMaintainingScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.only(left: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Serviços",
              style: Theme.of(context).textTheme.titleLarge,
              textAlign: TextAlign.start,
            ),
            for (final category in categories) ...[
              _buildSpotsGroup(context, category, experienceListMap),
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
    Map<ExperienceCategory, Set<ExperienceListItem>> experienceMapList,
  ) {
    final experiences = experienceMapList[category] ?? {};

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          category.name,
          style: Theme.of(context).textTheme.titleMedium,
          textAlign: TextAlign.start,
        ),
        // Padding(
        //   padding: const EdgeInsets.symmetric(horizontal: 14.0),
        SizedBox(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                for (final experience in experiences) ...[
                  buildExperienceItem(context, experience),
                  const SizedBox(
                    width: 10,
                  ),
                ],
              ],
            ),
          ),
        ),
        // ),
      ],
    );
  }

  Widget buildExperienceItem(
    BuildContext context,
    ExperienceListItem experience,
  ) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          14.0,
        ),
        side: const BorderSide(width: 2.0),
      ),
      margin: const EdgeInsets.symmetric(vertical: 4.0),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(14),
              child: SizedBox.fromSize(
                size: const Size.fromRadius(18),
                child: Image.network(
                  experience.imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(width: 8.0),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 12.0),
                child: Text(
                  experience.name,
                  style: Theme.of(context).textTheme.bodyMedium,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
