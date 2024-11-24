import 'package:equatable/equatable.dart';
import 'package:turismo_rural_frontend/core/utils/common.dart';

class ExperienceCategory extends Equatable {
  final String id;
  final String name;

  const ExperienceCategory({
    required this.id,
    required this.name,
  });

  factory ExperienceCategory.fromJson(Map<String, dynamic> json) {
    return ExperienceCategory(
      id: json['id'] as String,
      name: decodeUtf8(json['name'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }

  @override
  List<Object?> get props => [id, name];
}
