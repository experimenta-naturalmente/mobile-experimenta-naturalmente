import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:turismo_rural_frontend/core/data/models/experience.dart';

class SpotDetails extends StatelessWidget {
  final Experience experience;

  // make constructor
  const SpotDetails({super.key, required this.experience});
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
                    Text(
                      "Horário de atendimento",
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                for (final hour in experience.timeDetails)
                  Text(
                    hour,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        left: 10,
                        top: 45,
                        right: 45,
                      ),
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
                      ),
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
                      ),
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
