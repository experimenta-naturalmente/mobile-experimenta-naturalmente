import 'package:turismo_rural_frontend/features/experiences/data/model/experience_category.dart';
import 'package:turismo_rural_frontend/features/experiences/data/model/experience_list_item.dart';

abstract class IExperienceRepository {
  Future<List<ExperienceCategory>> fetchExperienceCategories();

  Future<List<ExperienceListItem>> fetchExperiencesfromCategory(
    ExperienceCategory category,
  );
}
