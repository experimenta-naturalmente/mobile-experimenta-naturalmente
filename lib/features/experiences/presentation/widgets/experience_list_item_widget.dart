import 'package:flutter/material.dart';
import 'package:turismo_rural_frontend/features/experiences/data/model/experience_list_item.dart';

class ExperienceListItemWidget extends StatelessWidget {
  final ExperienceListItem experience;
  final Function() onTap;

  const ExperienceListItemWidget({
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
          backgroundImage: NetworkImage(
            experience.imageUrl,
          ),
        ),
      ),
    );
  }
}
