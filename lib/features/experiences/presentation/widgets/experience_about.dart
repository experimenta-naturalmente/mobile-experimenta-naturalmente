import 'package:flutter/material.dart';
import 'package:turismo_rural_frontend/core/data/models/experience.dart';

class ExperienceAbout extends StatelessWidget {
  final Experience experience;

  const ExperienceAbout({super.key, required this.experience});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin: const EdgeInsets.only(top: 16),
        alignment: AlignmentDirectional.bottomStart,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    margin: const EdgeInsets.only(right: 6),
                    child: const Icon(Icons.sticky_note_2_outlined),
                  ),
                  Text(
                    experience.name,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                experience.description,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 14),
              Text(
                "Tags:",
                style: Theme.of(context).textTheme.labelLarge,
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 6,
                children: experience.tags.map((tag) {
                  return Chip(
                    backgroundColor: Colors.green.shade50,
                    label: Text(
                      tag.name,
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
