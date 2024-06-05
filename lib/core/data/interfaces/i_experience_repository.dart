import 'package:turismo_rural_frontend/core/data/models/event.dart';
import 'package:turismo_rural_frontend/core/data/models/experience.dart';
import 'package:turismo_rural_frontend/core/data/models/experience_category.dart';
import 'package:turismo_rural_frontend/core/data/models/spot.dart';

abstract class IExperienceRepository {
  Future<Set<ExperienceCategory>> fetchExperienceCategories();
  Future<Set<Experience>> fetchExperiencesFromCategory(
    ExperienceCategory category,
  );
  Future<Set<Event>> fetchFeaturedEvents();
  Future<Set<Spot>> fetchFeaturedSpots();
  Future<Spot> fetchFeaturedSpotById(int spotId);
}
