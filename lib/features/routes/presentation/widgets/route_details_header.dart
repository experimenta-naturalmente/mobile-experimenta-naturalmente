import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:turismo_rural_frontend/core/data/models/touristic_route.dart';

class RouteDetailsHeader extends StatelessWidget {
  final TouristicRoute route;

  const RouteDetailsHeader({
    required this.route,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          _buildRouteImage(context),
          const SizedBox(width: 16),
          ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: screenWidth * 0.5,
            ),
            child: Column(
              children: [
                Text(
                  route.name,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                Text(
                  route.description,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRouteImage(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final min = screenWidth < screenHeight ? screenWidth : screenHeight;
    final imageWidth = 50 + min * 0.05;
    return SizedBox(
      width: imageWidth,
      height: imageWidth,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12.0),
        child: CachedNetworkImage(
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
          ),
        ),
      ),
    );
  }
}
