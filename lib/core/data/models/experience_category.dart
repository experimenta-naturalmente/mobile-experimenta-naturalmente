import 'dart:convert';

import 'package:equatable/equatable.dart';

class ExperienceCategory extends Equatable {
  final int id;
  final String name;

  const ExperienceCategory({
    required this.id,
    required this.name,
  });

  factory ExperienceCategory.fromJson(Map<String, dynamic> json) {
    return ExperienceCategory(
      id: json['categoryId'] as int,
      name: utf8.decode((json['name'] as String).codeUnits),
    );
  }

  @override
  List<Object?> get props => [id, name];
}
