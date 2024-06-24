import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:turismo_rural_frontend/core/data/models/event.dart';

class EventDetails extends StatelessWidget {
  final Event event;

  const EventDetails({super.key, required this.event});

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
                    child: const Icon(Icons.home_filled),
                  ),
                  Text(
                    "Horários do Evento",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ],
              ),
              const SizedBox(height: 8),
              for (final hour in event.timeDetails)
                Text(
                  hour,
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
              const Row(
                mainAxisAlignment:
                    MainAxisAlignment.center, // Centraliza os ícones na linha
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      left: 10,
                      top: 45,
                      right: 45,
                    ), // Padding no ícone do Instagram
                    child: Icon(
                      FontAwesome.instagram,
                      size: 40,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      left: 10,
                      top: 45,
                      right: 10,
                    ), // Padding no ícone do Facebook
                    child: Icon(
                      FontAwesome.facebook,
                      size: 40,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      left: 45,
                      top: 45,
                      right: 10,
                    ), // Padding no ícone do WhatsApp
                    child: Icon(
                      FontAwesome.whatsapp,
                      size: 40,
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
