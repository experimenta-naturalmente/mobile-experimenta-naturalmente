import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:turismo_rural_frontend/core/data/models/experience.dart';
import 'package:url_launcher/url_launcher.dart';

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
              const SizedBox(height: 24),
              if (experience.tags.isNotEmpty) ...[
                Text(
                  "Tags:",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: experience.tags.map((tag) {
                    return Chip(
                      backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                      label: Text(
                        tag.name,
                        style: Theme.of(context).textTheme.labelMedium?.copyWith(
                          color: Theme.of(context).colorScheme.onPrimaryContainer,
                        ),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    );
                  }).toList(),
                ),
                const SizedBox(height: 16),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
