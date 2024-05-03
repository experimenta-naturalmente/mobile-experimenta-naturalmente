import 'dart:math';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:turismo_rural_frontend/core/data/models/experience.dart';

class EventListItem extends StatelessWidget {
  final Experience event;
  final Function() onTap;

  const EventListItem({
    super.key,
    required this.event,
    required this.onTap,
  });
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 360.0),
        itemBuilder: (BuildContext context, int index) {

            return _buildCarousel(context, index ~/ 2);
          
        },
      );
  
  }

  Widget _buildCarousel(BuildContext context, int carouselIndex) {
    return Wrap(
      children: <Widget>[
        const Padding(
          padding: EdgeInsets.only(left: 24.0),
          child: Text(
            "Eventos",
            textAlign: TextAlign.left,
            style: TextStyle(
              fontSize: 24,
            ),
          ),
        ),
        SizedBox(
          height: 175.0, // Altura do container que irá conter o Carousel
          width: MediaQuery.of(context).size.width, // Largura total da tela
          child: Stack(
            children: [
              Positioned(
                left: 0, // Movendo o Carousel para esquerda por 10 pixels
                right: -150,
                top: 0, // Alinhamento superior no Stack
                bottom: 0, // Alinhamento inferior no Stack
                child: CarouselSlider.builder(
                  itemCount: 5,
                  itemBuilder:
                      (BuildContext context, int itemIndex, int pageViewIndex) {
                    return _buildCarouselItem(
                        context, carouselIndex, itemIndex,);
                  },
                  options: CarouselOptions(
                    height: 400,
                    viewportFraction: 0.55,
                    padEnds: false,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCarouselItem(
    BuildContext context,
    int carouselIndex,
    int itemIndex,
  ) {
    final Random random = Random();
    final int randomId = random.nextInt(100) + 1; 
    return SizedBox(
      width: 330,
      child: Stack(
        alignment: AlignmentDirectional.bottomStart,
        children: [
          Positioned(
            top: 0,
            left: 20.0,
            right: 20.0,
            child: Container(
              height: 124.0,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                    'https://picsum.photos/id/$randomId/290/124',
                  ),
                  fit: BoxFit.cover, 
                ),
                borderRadius: const BorderRadius.all(Radius.circular(16.0)),
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(
              left: 22.0,
              top: 125.0,
              right: 63,
            ),
            child: Text(
              "Evento X: Seja bem vindo ao maior evento da cidade",
              textAlign: TextAlign.start,
              style: TextStyle(
                fontSize: 18,
              ),
            ),
          ),
        ],
      ),
    );
  }

}
