import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turismo_rural_frontend/config/navigation_cubit.dart';
import 'package:turismo_rural_frontend/core/data/models/route_item.dart';
import 'package:turismo_rural_frontend/core/utils/enums.dart';

class RouteDetailsCarousel extends StatefulWidget {
  final List<RouteItem> routeItemList;

  const RouteDetailsCarousel({super.key, required this.routeItemList});

  @override
  State<RouteDetailsCarousel> createState() => _RouteDetailsCarouselState();
}

class _RouteDetailsCarouselState extends State<RouteDetailsCarousel> {
  CarouselController carouselController = CarouselController();
  late RouteItem currentRouteItem;
  int currentRouteIndex = 0;

  @override
  void initState() {
    super.initState();
    currentRouteItem = widget.routeItemList.first;
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final carouselHeight = screenHeight * 0.3;
    final carouselWidth = carouselHeight * 16 / 9;

    return Column(
      children: [
        ShaderMask(
          shaderCallback: (Rect rect) {
            return LinearGradient(
              colors: [
                Colors.transparent,
                Theme.of(context).colorScheme.surface,
                Theme.of(context).colorScheme.surface,
                Colors.transparent,
              ],
              stops: const [0.0, 0.05, 0.95, 1.0],
            ).createShader(rect);
          },
          blendMode: BlendMode.dstIn,
          child: CarouselSlider.builder(
            carouselController: carouselController,
            itemCount: widget.routeItemList.length,
            itemBuilder: (BuildContext context, int index, int pageViewIndex) {
              final routeItem = widget.routeItemList.elementAt(index);
              return Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: MediaQuery.of(context).size.width * 0.01,
                ),
                child: SizedBox(
                  child: _buildItem(
                    context,
                    routeItem,
                    carouselHeight * 0.8,
                    carouselWidth * 0.8,
                  ),
                ),
              );
            },
            options: CarouselOptions(
              height: carouselHeight,
              viewportFraction:
                  carouselWidth / MediaQuery.of(context).size.width * 0.8,
              autoPlay: true,
              enableInfiniteScroll: false,
              autoPlayInterval: const Duration(seconds: 5),
              onPageChanged: (index, reason) {
                setState(() {
                  currentRouteItem = widget.routeItemList.elementAt(index);
                  currentRouteIndex = index;
                });
              },
            ),
          ),
        ),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  '${currentRouteIndex + 1} / ${widget.routeItemList.length}',
                  style: Theme.of(context).textTheme.labelLarge,
                ),
              ),
              const SizedBox(height: 4),
              Center(
                child: Text(
                  currentRouteItem.title,
                  style: Theme.of(context).textTheme.headlineMedium,
                  softWrap: true,
                ),
              ),
              const SizedBox(height: 12),
              Center(
                child: Text(
                  currentRouteItem.description,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
              const SizedBox(height: 12),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildItem(
    BuildContext context,
    RouteItem routeItem,
    double height,
    double width,
  ) {
    return GestureDetector(
      onTap: () {
        context.read<NavigationCubit>().navigateTo(
              appPage: AppPage.experiences,
              item: routeItem.experienceId,
            );
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: Theme.of(context).colorScheme.primary,
            width: 2,
          ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: CachedNetworkImage(
            imageUrl: routeItem.image,
            height: height,
            width: double.infinity,
            fit: BoxFit.cover,
            placeholder: (context, url) => const Center(
              child: CircularProgressIndicator(),
            ),
            errorWidget: (context, url, error) => Image.network(
              routeItem.image,
              height: height,
              width: width,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
