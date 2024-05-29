import 'package:turismo_rural_frontend/core/data/models/experience.dart';

class Spot extends Experience {
  final String openingHours;

  const Spot({
    required this.openingHours,
    required super.id,
    required super.name,
    required super.description,
    required super.category,
    required super.timeDetails,
    required super.socialNetworks,
    required super.tags,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        description,
        category,
        openingHours,
        timeDetails,
        socialNetworks,
        tags,
      ];
}
