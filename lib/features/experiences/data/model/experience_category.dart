import 'package:equatable/equatable.dart';

class ExperienceCategory extends Equatable {
  final int id;
  final String name;

  const ExperienceCategory({
    required this.id,
    required this.name,
  });

  @override
  List<Object?> get props => [id, name];
}
