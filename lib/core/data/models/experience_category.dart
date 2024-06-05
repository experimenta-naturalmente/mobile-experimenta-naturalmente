import 'dart:convert';

import 'package:equatable/equatable.dart';

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
      name: utf8.decode((json['name'] as String).codeUnits),
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
