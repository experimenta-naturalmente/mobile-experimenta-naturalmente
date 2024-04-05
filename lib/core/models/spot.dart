import 'package:turismo_rural_frontend/core/models/experience.dart';
import 'package:turismo_rural_frontend/features/experiences/data/model/experience_category.dart';

abstract class Spot extends Experience {
  //final int id;
  final String openingHours;

  const Spot({
    //required this.id,
    required this.openingHours,
  }) : super(
          id: 0,
          name: 'testeSpot',
          description: '',
          category: const ExperienceCategory(id: 0, name: 'teste'),
        );

  @override
  List<Object?> get props => [id, name, description, category];
}
