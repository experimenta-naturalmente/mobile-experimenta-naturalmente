import 'package:turismo_rural_frontend/features/attractions/data/models/attraction_model.dart';

abstract class IAttractionRepository {
  Future<List<Attraction>> fetchAttractions();
}
