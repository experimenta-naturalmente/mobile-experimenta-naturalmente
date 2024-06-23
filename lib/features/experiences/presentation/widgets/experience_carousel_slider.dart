import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:turismo_rural_frontend/core/data/models/experience.dart';

class ExperienceCarouselSlider extends StatefulWidget {
  final Experience experience;

  const ExperienceCarouselSlider({super.key, required this.experience});

  @override
  State<ExperienceCarouselSlider> createState() =>
      _ExperienceCarouselSliderState();
}

class _ExperienceCarouselSliderState extends State<ExperienceCarouselSlider> {
  CarouselController carouselController = CarouselController();

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      carouselController: carouselController,
      options: CarouselOptions(
        initialPage: 2,
        autoPlay: true,
        autoPlayInterval: const Duration(seconds: 5),
        enlargeCenterPage: true,
        viewportFraction: 0.75,
      ),
      items: widget.experience.attachments.map((attachment) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(28.0),
                border: Border.all(
                  width: 4,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(24.0),
                child: CachedNetworkImage(
                  imageUrl: attachment.url,
                  height: double.infinity,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => const Center(
                    child: SizedBox(
                      width: 50,
                      height: 50,
                      child: CircularProgressIndicator(),
                    ),
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
            );
          },
        );
      }).toList(),
    );
  }
}
