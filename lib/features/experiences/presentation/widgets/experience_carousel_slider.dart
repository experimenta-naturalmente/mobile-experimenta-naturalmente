import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class ExperienceCarouselSlider extends StatefulWidget {
  const ExperienceCarouselSlider({super.key});

  @override
  State<ExperienceCarouselSlider> createState() =>
      _ExperienceCarouselSliderState();
  // TODO: implement createState
}

class _ExperienceCarouselSliderState extends State<ExperienceCarouselSlider> {
  CarouselController carouselController = CarouselController();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return CarouselSlider(
      carouselController: carouselController,
      options: CarouselOptions(
        initialPage: 2,
        // reverse: false,
        autoPlay: true,
        autoPlayInterval: const Duration(seconds: 5),
        // autoPlayAnimationDuration: Duration(milliseconds: 800),
        // autoPlayCurve: Curves.fastOutSlowIn,
        // enlargeCenterPage: true,
        // enlargeFactor: 0.3,
      ),
      items: [
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR9j3w_2mh3w4-xZY-WnuORC-RpeRLq_x-ScA&s",
        "https://acontecegramado.com.br/wp-content/uploads/2024/01/sao-chico.jpeg",
      ].map((url) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
              // margin: EdgeInsets.symmetric(horizontal: 2.0),
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 218, 255, 7),
              ),
              child: Image.network(
                height: double.infinity,
                fit: BoxFit.cover,
                url,
              ),
            );
          },
        );
      }).toList(),
    );
  }
}
