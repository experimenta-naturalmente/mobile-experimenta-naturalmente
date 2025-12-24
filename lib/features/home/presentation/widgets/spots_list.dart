import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turismo_rural_frontend/config/navigation_cubit.dart';
import 'package:turismo_rural_frontend/core/data/models/attachment.dart';
import 'package:turismo_rural_frontend/core/data/models/experience_category.dart';
import 'package:turismo_rural_frontend/core/data/models/spot.dart';
import 'package:turismo_rural_frontend/core/utils/common.dart';
import 'package:turismo_rural_frontend/core/utils/enums.dart';
import 'package:turismo_rural_frontend/core/widgets/shared/faded_divider.dart';
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
    final spots = state.featuredExperiences.whereType<Spot>().toSet();
    final categories = spots.map((spot) => spot.category).toSet();
    final orientation = MediaQuery.of(context).orientation;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        for (int i = 0; i < categories.length; i++) ...[
          if (orientation == Orientation.portrait)
            _buildPortraitSpotsGroup(context, categories.elementAt(i), spots)
          else
            _buildLandscapeSpotsGroup(context, categories.elementAt(i), spots),
          Visibility(
            visible: i < categories.length - 1,
            replacement: const SizedBox(height: 16),
            child: Padding(
              padding: const EdgeInsets.only(top: 16),
              child:
                  FadedDivider(width: MediaQuery.of(context).size.width * 0.9),
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildPortraitSpotsGroup(
    BuildContext context,
    ExperienceCategory category,
    Set<Spot> spots,
  ) {
    final categorySpots =
        spots.where((spot) => spot.category.id == category.id).toList();
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    final cardHeight = screenHeight * 0.15;
    final cardWidth = screenWidth * 0.7;
    const maxCardWidth = 300.0;
    final adjustedCardWidth =
        cardWidth < maxCardWidth ? cardWidth : maxCardWidth;

    final spotsRows = categorySpots.length > 1 && screenHeight > 500 ? 2 : 1;
    final textTheme = screenWidth > 600
        ? Theme.of(context).textTheme.headlineMedium
        : Theme.of(context).textTheme.headlineSmall;

    final scrolls = categorySpots.length > 2;
    final fadeStops = scrolls ? [0.0, 0.9, 1.0] : [0.0, 1.0, 1.0];

    final ScrollController scrollController = ScrollController();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: screenWidth * 0.05, top: 18),
          child: RichText(
            text: TextSpan(
              style: textTheme,
              children: [
                WidgetSpan(
                  alignment: PlaceholderAlignment.middle,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 2, right: 12),
                    child: iconFromCategory(
                      experienceCategory: category,
                      color: textTheme!.color,
                      size: screenWidth > 600 ? 28 : 24,
                    ),
                  ),
                ),
                TextSpan(
                  text: category.name,
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
            height: cardHeight * spotsRows + 8,
            child: Scrollbar(
              controller: scrollController,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: SingleChildScrollView(
                  controller: scrollController,
                  scrollDirection: Axis.horizontal,
                  child: Wrap(
                    direction: Axis.vertical,
                    children: categorySpots.map((spot) {
                      return _buildSpotCard(
                        context,
                        spot,
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
      ],
    );
  }

  Widget _buildLandscapeSpotsGroup(
    BuildContext context,
    ExperienceCategory category,
    Set<Spot> spots,
  ) {
    final categorySpots =
        spots.where((spot) => spot.category.id == category.id).toList();
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    final cardHeight = screenHeight * 0.12;
    const minHeight = 100.0;
    final adjustedCardHeight = cardHeight > minHeight ? cardHeight : minHeight;
    final cardWidth = screenWidth * 0.5;
    const maxCardWidth = 300.0;
    final adjustedCardWidth =
        cardWidth < maxCardWidth ? cardWidth : maxCardWidth;

    final spotsRows = categorySpots.length > 1 && screenHeight > 500 ? 2 : 1;
    final textTheme = screenWidth > 600
        ? Theme.of(context).textTheme.headlineMedium
        : Theme.of(context).textTheme.headlineSmall;

    final scrolls = screenWidth / adjustedCardWidth < categorySpots.length / 2;
    final fadeStops = scrolls ? [0.0, 0.9, 1.0] : [0.0, 1.0, 1.0];

    final ScrollController scrollController = ScrollController();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: screenWidth * 0.05, top: 18),
          child: RichText(
            text: TextSpan(
              style: textTheme,
              children: [
                WidgetSpan(
                  alignment: PlaceholderAlignment.middle,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 2, right: 12),
                    child: iconFromCategory(
                      experienceCategory: category,
                      color: textTheme!.color,
                      size: screenWidth > 600 ? 28 : 24,
                    ),
                  ),
                ),
                TextSpan(
                  text: category.name,
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
            height: adjustedCardHeight * spotsRows + 8,
            child: Scrollbar(
              controller: scrollController,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: SingleChildScrollView(
                  controller: scrollController,
                  scrollDirection: Axis.horizontal,
                  child: Wrap(
                    direction: Axis.vertical,
                    children: categorySpots.map((spot) {
                      return _buildSpotCard(
                        context,
                        spot,
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

  Widget _buildSpotCard(
    BuildContext context,
    Spot spot,
    double cardHeight,
    double cardWidth,
    double margin,
  ) {
    return GestureDetector(
      onTap: () {
        context
            .read<NavigationCubit>()
            .navigateTo(appPage: AppPage.experiences, item: spot);
      },
      child: SizedBox(
        width: cardWidth,
        height: cardHeight,
        child: Card.outlined(
          margin: EdgeInsets.all(margin),
          child: Padding(
            padding: const EdgeInsets.all(6.0),
            child: Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    top: cardHeight * 0.05,
                    bottom: cardHeight * 0.05,
                  ),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      _buildSpotAvatar(
                        context,
                        spot.attachments.firstOrNull,
                        cardHeight * 0.35,
                      ),
                    ],
                  ),
                ),
                SizedBox(width: cardWidth * 0.05),
                Flexible(
                  flex: 2,
                  child: Text(
                    spot.name,
                    style: Theme.of(context).textTheme.titleMedium,
                    textAlign: TextAlign.left,
                    overflow: TextOverflow.fade,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSpotAvatar(
    BuildContext context,
    Attachment? att,
    double radius,
  ) {
    final border = Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: Theme.of(context).colorScheme.primary,
          width: 2.0,
        ),
      ),
    );

    if (att != null && att.hasBytes) {
      return Stack(
        alignment: Alignment.center,
        children: [
          border,
          CircleAvatar(
            radius: radius,
            backgroundImage: MemoryImage(att.bytes!),
          ),
        ],
      );
    }

    final url = att?.url ?? '';
    if (url.isEmpty) {
      return Stack(
        alignment: Alignment.center,
        children: [
          border,
          CircleAvatar(
            radius: radius,
            child: const Icon(Icons.image_not_supported),
          ),
        ],
      );
    }

    return Stack(
      alignment: Alignment.center,
      children: [
        border,
        CircleAvatar(
          radius: radius,
          backgroundImage: NetworkImage(url),
        ),
      ],
    );
  }
}
