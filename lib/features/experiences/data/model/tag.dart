import 'package:equatable/equatable.dart';
import 'package:turismo_rural_frontend/features/experiences/data/model/experience_category.dart';

class Tag extends Equatable {
  final int id;
  final String name;
  final ExperienceCategory type;

  const Tag({
    required this.id,
    required this.name,
    required this.type,
  });

  @override
  List<Object?> get props => [name, type];
}
