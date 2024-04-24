import 'package:flutter/material.dart';
import 'package:turismo_rural_frontend/core/data/models/experience.dart';

class EventListItem extends StatelessWidget {
  final Experience event;
  final Function() onTap;

  const EventListItem({
    super.key,
    required this.event,
    required this.onTap,
  });
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(event.name, maxLines: 1, overflow: TextOverflow.ellipsis),
      subtitle: Text(
        event.description,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
      onTap: onTap,
      leading: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(),
        ),
        child: const CircleAvatar(
          radius: 24,
        ),
      ),
    );
  }
}
