import 'package:turismo_rural_frontend/features/experiences/data/model/experience_category.dart';
import 'package:turismo_rural_frontend/features/experiences/data/model/experience_list_item.dart';

abstract class IExperienceRepository {
  Future<Set<ExperienceCategory>> fetchExperienceCategories();
  Future<Set<ExperienceListItem>> fetchExperiencesfromCategory(
    ExperienceCategory category,
  );
}
