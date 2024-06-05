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
        "https://garfoemala.com.br/wp-content/uploads/Luciano-Garcia-Divulga----o-70.jpg",
        "https://scontent.fpoa11-2.fna.fbcdn.net/v/t1.6435-9/85088740_2527758944001452_8160221692401025024_n.jpg?_nc_cat=105&ccb=1-7&_nc_sid=5f2048&_nc_eui2=AeGHzQ1SGfR-DrxjBAnbjZdsqCoyVfHpd_qoKjJV8el3-h9zDpL1uVDSmVuJi7E176WHgB8dY2QspxnDbGSiBr-D&_nc_ohc=PJYva68-VoQAb7vuqnV&_nc_ht=scontent.fpoa11-2.fna&oh=00_AfAYAhSH_usw6Q8qT2hXjqk1vrD9rgeTRtJ9--OrtS5OqA&oe=66393F32",
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
