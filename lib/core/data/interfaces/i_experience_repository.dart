import 'package:turismo_rural_frontend/core/data/models/experience_category.dart';
import 'package:turismo_rural_frontend/features/experiences/data/models/experience_list_item.dart';

abstract class IExperienceRepository {
  Future<Set<ExperienceCategory>> fetchExperienceCategories();
  Future<Set<ExperienceListItem>> fetchExperiencesfromCategory(
    ExperienceCategory category,
  );
}
