import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:turismo_rural_frontend/core/data/models/attachment.dart';
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
    final screenHeight = MediaQuery.of(context).size.height;
    final experienceHeight = screenHeight * 0.3;
    final experienceWidth = experienceHeight * 16 / 9;

    return Visibility(
      visible: widget.experience.attachments.isNotEmpty,
      child: ShaderMask(
        shaderCallback: (Rect rect) {
          return LinearGradient(
            colors: [
              Colors.transparent,
              Theme.of(context).colorScheme.surface,
              Theme.of(context).colorScheme.surface,
              Colors.transparent,
            ],
            stops: const [0.0, 0.1, 0.9, 1.0],
          ).createShader(rect);
        },
        blendMode: BlendMode.dstIn,
        child: CarouselSlider.builder(
          carouselController: carouselController,
          itemCount: widget.experience.attachments.length,
          itemBuilder: (BuildContext context, int index, int pageViewIndex) {
            final attachment = widget.experience.attachments.elementAt(index);
            return Padding(
              padding: EdgeInsets.symmetric(
                vertical: 8,
                horizontal: MediaQuery.of(context).size.width * 0.01,
              ),
              child: _buildItem(
                context,
                attachment,
                experienceHeight,
                experienceWidth,
              ),
            );
          },
          options: CarouselOptions(
            height: experienceHeight,
            viewportFraction:
                experienceWidth / MediaQuery.of(context).size.width * 0.8,
            autoPlay: true,
            autoPlayInterval: const Duration(seconds: 5),
          ),
        ),
      ),
    );
  }

  Widget _buildItem(
    BuildContext context,
    Attachment attachment,
    double eventHeight,
    double eventWidth,
  ) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Theme.of(context).colorScheme.primary,
          width: 2,
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: CachedNetworkImage(
          imageUrl: attachment.url,
          width: double.infinity,
          fit: BoxFit.cover,
          placeholder: (context, url) => const Center(
            child: CircularProgressIndicator(),
          ),
          errorWidget: (context, url, error) => Image.network(
            attachment.url,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}
