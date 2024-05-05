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
          return _buildCarousel(context, index ~/ 2);
        },
      ),
    );
  }

  Widget _buildCarousel(BuildContext context, int carouselIndex) {
    return Wrap(
      children: <Widget>[
        const Text(
          "Eventos",
          textAlign: TextAlign.left,
          style: TextStyle(
            fontSize: 26,
          ),
        ),
        SizedBox(
          // you may want to use an aspect ratio here for tablet support
          height: 155.0,
          width: 800,
          child: PageView.builder(
            // store this controller in a State to save the carousel scroll position
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
          right: 30.0,
          child: Container(
            height: 120.0,
            width: 20.0,
            decoration: const BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.all(Radius.circular(16.0)),
            ),
          ),
        ),
        const Text(
          "Eventos",
          textAlign: TextAlign.left,
          style: TextStyle(
            fontSize: 26,
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
