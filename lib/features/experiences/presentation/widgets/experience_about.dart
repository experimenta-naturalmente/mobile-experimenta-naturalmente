import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:turismo_rural_frontend/core/data/models/experience.dart';
import 'package:url_launcher/url_launcher.dart';

class ExperienceAbout extends StatelessWidget {
  final Experience experience;

  const ExperienceAbout({super.key, required this.experience});

  Future<void> _launchEmail(String email) async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: email,
      queryParameters: {
        'subject': 'Olá',
        'body': 'Gostaria de te perguntar ',
      },
    );
    if (await canLaunchUrl(emailUri)) {
      await launchUrl(emailUri);
    } else {
      print('Não foi possível abrir o email.');
    }
  }

  Future<void> _launchPhone(String phoneNumber) async {
    final Uri phoneUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    if (await canLaunchUrl(phoneUri)) {
      await launchUrl(phoneUri);
    } else {
      print('Não foi possível fazer a chamada.');
    }
  }

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
              Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 12), // espaçamento vertical
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(child: Text('Telefone: ${experience.phone}')),
                    IconButton(
                      icon: const Icon(FontAwesome.phone, size: 30),
                      tooltip: 'Fazer Chamada',
                      onPressed: () => _launchPhone(experience.phone!),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 12), // espaçamento vertical
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(child: Text('Email: ${experience.email}')),
                    IconButton(
                      icon: const Icon(FontAwesome.mail, size: 30),
                      tooltip: 'Enviar Email',
                      onPressed: () => _launchEmail(experience.email!),
                    ),
                  ],
                ),
              ),
              Visibility(
                visible: experience.tags.isNotEmpty,
                child: Text(
                  "Tags:",
                  style: Theme.of(context).textTheme.labelLarge,
                ),
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
