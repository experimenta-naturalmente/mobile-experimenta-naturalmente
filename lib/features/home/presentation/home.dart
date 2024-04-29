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
      children: <Widget>[
        const Padding(
          padding: EdgeInsets.only(left: 24.0),
          child: Text(
            "Eventos1",
            textAlign: TextAlign.left,
            style: TextStyle(
              fontSize: 24,
            ),
          ),
        ),
        SizedBox(
          height: 175.0,
          child: PageView.builder(
            itemCount: 5, // Número de itens no carrossel
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
    return SizedBox(
      width: 100.0,
      child: Stack(
        children: [
          /*Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.red, // Cor da borda para visibilidade
                width: 2.0, // Espessura da borda
              ),
            ),
          ),*/
          Positioned(
            top: 0,
            left: 20.0,
            right: 20.0,
            child: Container(
              height: 124.0,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                      'https://www.rbsdirect.com.br/filestore/1/2/5/0/9/8/4_361e19f93784fa6/4890521_aef3999fcc0f380.jpg?w=1024&h=768&a=c'),
                  fit: BoxFit.cover, // Ajuste da imagem dentro do Container
                ),
                borderRadius: BorderRadius.all(Radius.circular(16.0)),
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(
              left: 22.0,
              top: 125.0,
              right: 63,
            ), // Adicionar padding à esquerda
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

  State<StatefulWidget> createState() {
    // TODO: implement createState
    throw UnimplementedError();
  }
}
