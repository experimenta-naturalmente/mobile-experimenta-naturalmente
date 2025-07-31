import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:intl/intl.dart';
import 'package:turismo_rural_frontend/core/data/models/event.dart';
import 'package:url_launcher/url_launcher.dart';

class EventDetails extends StatelessWidget {
  final Event event;

  const EventDetails({super.key, required this.event});

  Future<void> _launchURL(String url) async {
    print('pressed event class $url');
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      throw 'Não foi possível abrir o link na event class: $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    const String instagramUrl = 'https://www.instagram.com/teste';
    const String facebookUrl = 'https://www.facebook.com/teste';
    const String whatsappUrl = 'https://wa.me/5511999999999';
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
                    child: const Icon(Icons.access_time),
                  ),
                  Text(
                    "Horários do Evento",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                "Início: ${DateFormat('dd/MM/yyyy HH:mm').format(DateTime.parse(event.eventStart))}",
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 8),
              Text(
                "Fim: ${DateFormat('dd/MM/yyyy HH:mm').format(DateTime.parse(event.eventEnd))}",
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Container(
                    margin: const EdgeInsets.only(right: 6),
                    child: const Icon(Icons.access_time_outlined),
                  ),
                  Text(
                    "Detalhes",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                event.details,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 10,
                      top: 45,
                      right: 45,
                    ),
                    child: IconButton(
                      icon: const Icon(FontAwesome.instagram, size: 40),
                      onPressed: () => _launchURL(instagramUrl),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 10,
                      top: 45,
                      right: 10,
                    ),
                    child: IconButton(
                      icon: const Icon(FontAwesome.facebook, size: 40),
                      onPressed: () => _launchURL(facebookUrl),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 45,
                      top: 45,
                      right: 10,
                    ),
                    child: IconButton(
                      icon: const Icon(FontAwesome.whatsapp, size: 40),
                      onPressed: () => _launchURL(whatsappUrl),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
