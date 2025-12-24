import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:turismo_rural_frontend/core/data/models/attachment.dart';
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
            child: _buildImage(experience.attachments.firstOrNull),
          ),
        ),
      ),
    );
  }

  Widget _buildImage(Attachment? att) {
    if (att != null && att.hasBytes) {
      return Image.memory(
        att.bytes!,
        fit: BoxFit.cover,
        width: 48,
        height: 48,
      );
    }

    final url = att?.url ?? '';
    if (url.isEmpty) {
      return const Icon(Icons.image_not_supported);
    }

    return CachedNetworkImage(
      imageUrl: url,
      fit: BoxFit.cover,
      width: 48,
      height: 48,
      placeholder: (context, url) => const CircularProgressIndicator(),
      errorWidget: (context, url, error) => const Icon(Icons.broken_image),
    );
  }
}
