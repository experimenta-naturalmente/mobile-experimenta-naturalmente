import 'package:image_picker/image_picker.dart';
import 'package:turismo_rural_frontend/core/data/models/experience.dart';
import 'package:turismo_rural_frontend/core/data/models/experience_category.dart';

abstract class IExperienceRepository {
  Future<Set<ExperienceCategory>> fetchExperienceCategories();
  Future<Set<Experience>> fetchExperiencesFromCategory(
    ExperienceCategory category,
  );
  Future<Set<Experience>> fetchFeaturedExperiences();
  Future<Experience?> fetchExperienceById(String id);
  Future<String?> uploadImage(XFile file, Function(int) onProgress);
}
