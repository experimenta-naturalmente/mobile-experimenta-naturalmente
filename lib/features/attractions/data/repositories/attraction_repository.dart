import 'package:turismo_rural_frontend/features/attractions/data/interfaces/i_attraction_repository.dart';
import 'package:turismo_rural_frontend/features/attractions/data/models/attraction_model.dart';

class AttractionRepository implements IAttractionRepository {
  @override
  Future<List<Attraction>> fetchAttractions() async {
    return <Attraction>[
      Attraction(
        id: 1,
        name: 'Cachoeira do Itiquira',
        description:
            'Cachoeira do Itiquira é uma das maiores cachoeiras do Brasil, com 168 metros de altura.',
      ),
      Attraction(
        id: 2,
        name: 'Cachoeira do Tororó',
        description:
            'Cachoeira do Tororó é uma das cachoeiras mais bonitas do Brasil, com 80 metros de altura.',
      ),
      Attraction(
        id: 3,
        name: 'Cachoeira do Rosário',
        description:
            'Cachoeira do Rosário é uma das cachoeiras mais bonitas do Brasil, com 60 metros de altura.',
      ),
    ];
  }
}
