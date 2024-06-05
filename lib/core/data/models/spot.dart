// ignore_for_file: avoid_dynamic_calls

import 'dart:convert';

import 'package:turismo_rural_frontend/core/data/models/experience.dart';
import 'package:turismo_rural_frontend/core/data/models/experience_category.dart';
import 'package:turismo_rural_frontend/core/data/models/tag.dart';

class Spot extends Experience {
  final String openingHours;

  const Spot({
    required this.openingHours,
    required super.id,
    required super.cnpj,
    required super.name,
    required super.email,
    required super.phone,
    required super.image,
    required super.description,
    required super.category,
    required super.timeDetails,
    required super.socialNetworks,
    required super.tags,
  });

  factory Spot.fromJson(
    Map<String, dynamic> json,
    List<ExperienceCategory> categories,
  ) {
    return Spot(
      openingHours: json['openingHours'] as String,
      id: json['id'] as int,
      cnpj: json['cnpj'] as String,
      name: utf8.decode((json['name'] as String).codeUnits),
      email: json['email'] as String,
      timeDetails: const [],
      phone: json['phone'] as String,
      image: json['image'] as String?,
      description: utf8.decode((json['description'] as String).codeUnits),
      category: categories.firstWhere(
        (category) => category.id == json['category']['categoryId'] as int,
        orElse: () => const ExperienceCategory(
          id: -1,
          name: 'Unknown',
        ),
      ),
      socialNetworks: const [],
      tags: (json['tags'] as List<dynamic>)
          .map((tag) => Tag.fromJson(tag as Map<String, dynamic>))
          .toSet(),
    );
  }

  factory Spot.fromJsonCategorized(
    Map<String, dynamic> json,
    ExperienceCategory category,
  ) {
    return Spot(
      openingHours: json['openingHours'] as String,
      id: json['id'] as int,
      cnpj: json['cnpj'] as String,
      name: utf8.decode((json['name'] as String).codeUnits),
      email: json['email'] as String,
      phone: json['phone'] as String,
      image: json['image'] as String?,
      description: utf8.decode((json['description'] as String).codeUnits),
      category: category,
      timeDetails: const [],
      socialNetworks: const [],
      tags: (json['tags'] as List<dynamic>)
          .map((tag) => Tag.fromJson(tag as Map<String, dynamic>))
          .toSet(),
    );
  }

  @override
  List<Object?> get props => [
        id,
        cnpj,
        name,
        email,
        phone,
        image,
        description,
        category,
        openingHours,
        timeDetails,
        socialNetworks,
        tags,
      ];
}
