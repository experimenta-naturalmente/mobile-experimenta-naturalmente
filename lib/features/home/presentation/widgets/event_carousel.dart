import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:turismo_rural_frontend/config/navigation_cubit.dart';
import 'package:turismo_rural_frontend/core/data/models/attachment.dart';
import 'package:turismo_rural_frontend/core/data/models/event.dart';
import 'package:turismo_rural_frontend/core/utils/common.dart';
import 'package:turismo_rural_frontend/core/utils/enums.dart';
import 'package:turismo_rural_frontend/features/home/bloc/home_bloc.dart';
import 'package:turismo_rural_frontend/features/home/bloc/home_state.dart';

class EventCarousel extends StatefulWidget {
  const EventCarousel({
    super.key,
  });

  @override
  State<EventCarousel> createState() => _EventCarouselState();
}

class _EventCarouselState extends State<EventCarousel> {
  final CarouselSliderController _carouselController =
      CarouselSliderController();
  Timer? _autoPlayTimer;
  bool _isPaused = false;
  int _currentIndex = 0;

  @override
  void dispose() {
    _autoPlayTimer?.cancel();
    super.dispose();
  }

  void _startAutoPlay(int itemCount) {
    _autoPlayTimer?.cancel();
    if (!_isPaused && itemCount > 0) {
      _autoPlayTimer = Timer.periodic(const Duration(seconds: 3), (timer) {
        if (!_isPaused && mounted) {
          _carouselController.nextPage(
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut,
          );
        }
      });
    }
  }

  void _pauseAutoPlay() {
    setState(() {
      _isPaused = true;
    });
    _autoPlayTimer?.cancel();
  }

  void _resumeAutoPlay(int itemCount) {
    setState(() {
      _isPaused = false;
    });
    _startAutoPlay(itemCount);
  }

  @override
  Widget build(BuildContext context) {
    if (context.watch<HomeBloc>().state is! HomeLoaded) {
      return const SizedBox();
    }
    final state = context.watch<HomeBloc>().state as HomeLoaded;
    final events = state.featuredExperiences.whereType<Event>().toList();

    if (events.isEmpty) {
      return const SizedBox();
    }

    // Inicia autoplay quando há eventos
    if (_autoPlayTimer == null || !_autoPlayTimer!.isActive) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _startAutoPlay(events.length);
      });
    }

    return _buildCarousel(context, events);
  }

  Widget _buildCarousel(BuildContext context, List<Event> events) {
    final screenWidth = MediaQuery.of(context).size.width;
    final imageWidth = screenWidth * 0.75;
    final imageHeight = imageWidth * 0.6; // Proporção 5:3

    final textTheme = screenWidth > 600
        ? Theme.of(context).textTheme.headlineMedium
        : Theme.of(context).textTheme.headlineSmall;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.05,
          ),
          child: Text(
            "Eventos",
            style: textTheme!.copyWith(fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(height: 16),
        GestureDetector(
          onLongPressStart: (_) => _pauseAutoPlay(),
          onLongPressEnd: (_) => _resumeAutoPlay(events.length),
          child: CarouselSlider.builder(
            carouselController: _carouselController,
            itemCount: events.length,
            itemBuilder: (BuildContext context, int index, int pageViewIndex) {
              final event = events[index];
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: _buildItem(context, event, imageWidth, imageHeight),
              );
            },
            options: CarouselOptions(
              height:
                  imageHeight + 80, // altura da imagem + espaço para legenda
              viewportFraction:
                  0.85, // Mostra 85% da imagem atual com espaço visível
              enlargeCenterPage:
                  false, // Desativa ampliação para manter proporções
              autoPlay: false, // Desativado porque controlamos manualmente
              enableInfiniteScroll: events.length > 1,
              scrollDirection: Axis.horizontal,
              padEnds:
                  false, // Remove padding nas extremidades para rolagem infinita contínua
              onPageChanged: (index, reason) {
                setState(() {
                  _currentIndex = index;
                });
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildItem(
    BuildContext context,
    Event event,
    double imageWidth,
    double imageHeight,
  ) {
    final Attachment? att = event.attachments.firstOrNull;
    return GestureDetector(
      onTap: () {
        context
            .read<NavigationCubit>()
            .navigateTo(appPage: AppPage.experiences, item: event);
      },
      child: Column(
        children: [
          Container(
            width: imageWidth,
            height: imageHeight,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: Theme.of(context).colorScheme.outline,
                width: 2,
              ),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: _buildAttachmentImage(att, imageWidth, imageHeight),
            ),
          ),
          const SizedBox(height: 12),
          Container(
            width: imageWidth,
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: RichText(
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              text: TextSpan(
                style: Theme.of(context).textTheme.bodyMedium,
                children: [
                  TextSpan(
                    text: event.name.toLowerCase().replaceFirst(
                        event.name[0].toLowerCase(),
                        event.name[0].toUpperCase()),
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                    text: ': ${event.description}',
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAttachmentImage(Attachment? att, double w, double h) {
    if (att != null && att.hasBytes) {
      return Image.memory(
        att.bytes!,
        width: w,
        height: h,
        fit: BoxFit.cover,
      );
    }

    final url = att?.url ?? '';
    if (url.isEmpty) {
      return Container(
        color: Colors.grey.shade200,
        width: w,
        height: h,
        child: const Icon(Icons.image_not_supported),
      );
    }

    return CachedNetworkImage(
      width: w,
      height: h,
      imageUrl: url,
      fit: BoxFit.cover,
      placeholder: (context, _) => const Center(
        child: CircularProgressIndicator(),
      ),
      errorWidget: (context, _, __) => Container(
        color: Colors.grey.shade200,
        child: const Icon(Icons.broken_image),
      ),
    );
  }
}
