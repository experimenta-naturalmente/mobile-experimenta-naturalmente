import 'package:equatable/equatable.dart';

class ExperienceListItem extends Equatable {
  final int id;
  final String name;
  final String description;
  final String imageUrl;

  const ExperienceListItem({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
  });

  @override
  List<Object?> get props => [id, name, description, imageUrl];
}
