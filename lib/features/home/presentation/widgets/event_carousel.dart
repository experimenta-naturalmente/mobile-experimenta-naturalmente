import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class EventCarousel extends StatelessWidget {
  const EventCarousel({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return _buildCarousel(context);
  }

  Widget _buildCarousel(BuildContext context) {
    final eventHeight = MediaQuery.of(context).size.height * 0.2;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 24.0),
          child: Text(
            "Eventos",
            textAlign: TextAlign.left,
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
        CarouselSlider.builder(
          itemCount: 5,
          itemBuilder:
              (BuildContext context, int itemIndex, int pageViewIndex) {
            return _buildItem(context, itemIndex, eventHeight);
          },
          options: CarouselOptions(
            height: eventHeight + 80,
            viewportFraction: 0.75,
            enableInfiniteScroll: false,
            enlargeCenterPage: true,
          ),
        ),
      ],
    );
  }

  Widget _buildItem(BuildContext context, int index, double eventHeight) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.75,
            height: eventHeight,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: Theme.of(context).colorScheme.outline,
                width: 2,
              ),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                'https://picsum.photos/200/300?random=$index',
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(
              'Description of event $index',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
        ],
      ),
    );
  }
}
