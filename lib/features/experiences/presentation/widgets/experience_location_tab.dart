import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:turismo_rural_frontend/core/data/models/experience.dart';
import 'package:turismo_rural_frontend/core/services/maps/maps.dart';

class ExperienceLocationTab extends StatefulWidget {
  final Experience experience;

  const ExperienceLocationTab({super.key, required this.experience});

  @override
  State<ExperienceLocationTab> createState() => _ExperienceLocationTabState();
}

class _ExperienceLocationTabState extends State<ExperienceLocationTab> {
  late final Future<Widget> _mapFuture;

  @override
  void initState() {
    super.initState();
    _mapFuture = context.read<IMapsService>().buildMap(const {});
  }

  @override
  Widget build(BuildContext context) {
    final experience = widget.experience;
    final screenHeight = MediaQuery.of(context).size.height;

    return SingleChildScrollView(
      child: Container(
        margin: const EdgeInsets.only(top: 16),
        alignment: AlignmentDirectional.bottomStart,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    margin: const EdgeInsets.only(right: 6),
                    child: const Icon(Icons.near_me_outlined),
                  ),
                  Text(
                    "Endereço",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                '${experience.address.street}, ${experience.address.number}',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 8),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(),
                ),
                height: screenHeight * 0.20,
                child: FutureBuilder<Widget>(
                  future: _mapFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return const Center(
                        child: Text("Erro ao carregar o mapa."),
                      );
                    } else {
                      return snapshot.data ?? const SizedBox.shrink();
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
