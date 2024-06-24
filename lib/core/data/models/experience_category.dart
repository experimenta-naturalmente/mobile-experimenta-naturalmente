import 'package:equatable/equatable.dart';
import 'package:turismo_rural_frontend/core/utils/common.dart';

class ExperienceCategory extends Equatable {
  final int categoryId;
  final String name;

  const ExperienceCategory({
    required this.categoryId,
    required this.name,
  });

  factory ExperienceCategory.fromJson(Map<String, dynamic> json) {
    return ExperienceCategory(
      categoryId: json['categoryId'] as int,
      name: decodeUtf8(json['name'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'categoryId': categoryId,
      'name': name,
    };
  }

  @override
  List<Object?> get props => [categoryId, name];
}
