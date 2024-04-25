import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Carousel in vertical scrollable'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 360.0),
        itemBuilder: (BuildContext context, int index) {
          // ignore: use_is_even_rather_than_modulo
          if (index % 2 == 0) {
            return _buildCarousel(context, index ~/ 2);
          }
          return null;
        },
      ),
    );
  }

  Widget _buildCarousel(BuildContext context, int carouselIndex) {
    return Wrap(
      spacing: 10.0,
      children: <Widget>[
        const Padding(
          padding: EdgeInsets.only(left: 24.0), // Adicionar padding à esquerda
          child: Text(
            "Eventos",
            textAlign: TextAlign.left,
            style: TextStyle(
              fontSize: 24,
            ),
          ),
        ),
        SizedBox(
          // you may want to use an aspect ratio here for tablet support
          height: 175.0,
          child: PageView.builder(
            itemBuilder: (BuildContext context, int itemIndex) {
              return _buildCarouselItem(context, carouselIndex, itemIndex);
            },
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
    return Stack(
      alignment: AlignmentDirectional.bottomStart,
      children: [
        Positioned(
          top: 0, // Ajuste esse valor conforme necessário para mover para cima
          left: 20.0,
          right: 63.0,
          child: Container(
            height: 124.0,
            width: 350.0,
            decoration: const BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.all(Radius.circular(16.0)),
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(
              left: 22.0,
              top: 120.0,
              right: 63,), // Adicionar padding à esquerda
          child: Text(
            "Evento X: Seja bem vindo ao maior evento da cidade",
            textAlign: TextAlign.start,
            style: TextStyle(
              fontSize: 18,
            ),
          ),
        ),
      ],
    );
  }
}

@override
State<StatefulWidget> createState() {
  // TODO: implement createState
  throw UnimplementedError();
}
