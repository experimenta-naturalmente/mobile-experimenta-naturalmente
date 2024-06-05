import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:turismo_rural_frontend/core/data/models/experience.dart';

class ExperienceWidget extends StatelessWidget {
  final Experience experience;
  final Function() onTap;

  const ExperienceWidget({
    super.key,
    required this.experience,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title:
          Text(experience.name, maxLines: 1, overflow: TextOverflow.ellipsis),
      subtitle: Text(
        experience.description,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
      onTap: onTap,
      leading: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(),
        ),
        child: CircleAvatar(
          radius: 24,
          backgroundColor: Colors.transparent,
          child: ClipOval(
            child: CachedNetworkImage(
              imageUrl: experience.image ??
                  experience.images.firstOrNull ??
                  'https://picsum.photos/200/300?random=${experience.id}',
              fit: BoxFit.cover,
              width: 48,
              height: 48,
              placeholder: (context, url) => const CircularProgressIndicator(),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
          ),
        ),
      ),
    );
  }
}
