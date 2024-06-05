import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:turismo_rural_frontend/core/data/models/experience_category.dart';

class Tag extends Equatable {
  final int id;
  final String name;
  final List<ExperienceCategory> type;

  const Tag({
    required this.id,
    required this.name,
    required this.type,
  });

  @override
  List<Object?> get props => [name, type];

  factory Tag.fromJson(Map<String, dynamic> json) {
    final categoryJsonList = json['categories'] as List<dynamic>;

    final List<ExperienceCategory> categoryList = categoryJsonList
        .map(
          (categoryJson) =>
              ExperienceCategory.fromJson(categoryJson as Map<String, dynamic>),
        )
        .toList();

    return Tag(
      id: json['tagId'] as int,
      name: utf8.decode((json['name'] as String).codeUnits),
      type: categoryList,
    );
  }
}
