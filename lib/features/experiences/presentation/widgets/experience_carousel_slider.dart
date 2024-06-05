import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class ExperienceCarouselSlider extends StatefulWidget {
  const ExperienceCarouselSlider({super.key});

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
      items: [
        "https://garfoemala.com.br/wp-content/uploads/Luciano-Garcia-Divulga----o-70.jpg",
        "https://s2.glbimg.com/RVgdmixaEN_wGb6DcqqtgkIvTC8=/620x465/s.glbimg.com/jo/g1/f/original/2014/01/17/passo_lha.jpg",
        "https://cdn.temporadalivre.com/blog-media/posts/cover/11263/size_800_sao-francisco-de-paula-onde-fica-o-que-fazer-e-muito-mais-5f03c48b.jpg",
        "https://www.portaldasmissoes.com.br/uploads/noticias/0004344_zoom_sao-francisco-de-paula-rs.png",
      ].map((url) {
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
                  imageUrl: url,
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
