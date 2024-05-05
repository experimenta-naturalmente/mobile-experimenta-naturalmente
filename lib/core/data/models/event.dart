import 'package:turismo_rural_frontend/core/data/models/experience.dart';

class Event extends Experience {
  final String about;

  const Event({
    required this.about,
    required super.id,
    required super.name,
    required super.description,
    required super.category,
  });

  @override
  List<Object?> get props => [id, name, description, about, category];
}
