import 'package:flutter/material.dart';
import 'package:turismo_rural_frontend/core/data/models/experience.dart';

class SpotListItem extends StatelessWidget {
  final Experience spot;
  final Function() onTap;

  const SpotListItem({
    super.key,
    required this.spot,
    required this.onTap,
  });
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(spot.name, maxLines: 1, overflow: TextOverflow.ellipsis),
      subtitle: Text(
        spot.description,
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
