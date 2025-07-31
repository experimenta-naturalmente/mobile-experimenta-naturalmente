import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:turismo_rural_frontend/core/data/models/spot.dart';
import 'package:url_launcher/url_launcher.dart';

class SpotDetails extends StatelessWidget {
  final Spot spot;

  String _weekdayName(String openingHour) {
    switch (openingHour) {
      case 'monday':
        return 'Segunda-feira';
      case 'tuesday':
        return 'Terça-feira';
      case 'wednesday':
        return 'Quarta-feira';
      case 'thursday':
        return 'Quinta-feira';
      case 'friday':
        return 'Sexta-feira';
      case 'saturday':
        return 'Sábado';
      case 'sunday':
        return 'Domingo';
      case 'holiday':
        return 'Feriados';
      default:
        return '';
    }
  }

  Future<void> _launchURL(String? url) async {
    if (url == null || url.isEmpty) {
      print('URL inválida no launchURL');
      return;
    }
    final uri = Uri.tryParse(url);
    if (uri == null) {
      print('URL mal formatada');
      return;
    }
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      throw 'Não foi possível abrir o link: $url';
    }
  }

  const SpotDetails({super.key, required this.spot});

  @override
  Widget build(BuildContext context) {
    if (spot.socialNetworks == null) {
      return const SizedBox.shrink(); // não mostra nada
    }
    final String? instagramHandle = spot.socialNetworks!.instagram;
    final String? facebookHandle = spot.socialNetworks!.facebook;
    final String? whatsappNumber = spot.socialNetworks!.whatsapp;

    final String? instagramUrl = (instagramHandle?.isNotEmpty ?? false)
        ? 'https://www.instagram.com/$instagramHandle'
        : null;

    final String? facebookUrl = (facebookHandle?.isNotEmpty ?? false)
        ? 'https://www.facebook.com/$facebookHandle'
        : null;

    final String? whatsappUrl = (whatsappNumber?.isNotEmpty ?? false)
        ? 'https://wa.me/$whatsappNumber'
        : null;
    return Container(
      margin: const EdgeInsets.only(top: 16),
      alignment: AlignmentDirectional.topStart,
      child: SingleChildScrollView(
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
                  for (final openingHour in spot.openingHours)
                    Text(
                      "${_weekdayName(openingHour.dayOfWeek)}: ${openingHour.openingHour} - ${openingHour.closingHour}",
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 24),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (spot.socialNetworks!.instagram?.isNotEmpty ?? false)
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 10,
                              right: 45,
                            ),
                            child: IconButton(
                              icon: const Icon(FontAwesome.instagram, size: 40),
                              onPressed: () => _launchURL(instagramUrl),
                            ),
                          ),
                        if (spot.socialNetworks!.facebook?.isNotEmpty ?? false)
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 10,
                              right: 10,
                            ),
                            child: IconButton(
                              icon: const Icon(FontAwesome.facebook, size: 40),
                              onPressed: () => _launchURL(facebookUrl),
                            ),
                          ),
                        if (spot.socialNetworks!.whatsapp?.isNotEmpty ?? false)
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 45,
                              right: 10,
                            ),
                            child: IconButton(
                              icon: const Icon(FontAwesome.whatsapp, size: 40),
                              onPressed: () => _launchURL(whatsappUrl),
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
