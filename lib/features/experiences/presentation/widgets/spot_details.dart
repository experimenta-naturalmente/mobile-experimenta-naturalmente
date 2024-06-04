import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:turismo_rural_frontend/features/experiences/presentation/view_models/experience_list_item.dart';

class SpotDetails extends StatelessWidget {
  final ExperienceListItem experienceListItem;

  // make constructor
  const SpotDetails({super.key, required this.experienceListItem});
  // make constructor

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Container(
      margin: const EdgeInsets.only(top: 16),
      alignment: AlignmentDirectional.bottomStart,
      child: Column(
        children: [
          Container(
            alignment: Alignment.topLeft,
            margin: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(right: 6),
                      child: const Icon(Icons.access_time_outlined),
                    ),
                    const Text(
                      "Horário de atendimento",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                for (final hour in experienceListItem.timeDetails)
                  Text(
                    hour,
                    style: const TextStyle(
                      fontSize: 14,
                    ),
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
                        FontAwesomeIcons.instagram,
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
                        FontAwesomeIcons.facebook,
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
                        FontAwesomeIcons.whatsapp,
                        size: 40,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
