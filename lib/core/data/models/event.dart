import 'dart:convert';

import 'package:turismo_rural_frontend/core/data/models/experience.dart';
import 'package:turismo_rural_frontend/core/data/models/experience_category.dart';
import 'package:turismo_rural_frontend/core/data/models/tag.dart';

class Event extends Experience {
  final String details;
  final String time;

  const Event({
    required this.details,
    required this.time,
    required super.id,
    required super.cnpj,
    required super.name,
    required super.image,
    required super.email,
    required super.phone,
    required super.description,
    required super.category,
    required super.timeDetails,
    required super.socialNetworks,
    required super.tags,
    required super.images,
  });

  factory Event.fromJson(
    Map<String, dynamic> json,
    List<ExperienceCategory> categories,
  ) {
    return Event(
      details: utf8.decode((json['details'] as String).codeUnits),
      time: json['time'] as String,
      id: json['id'] as int,
      cnpj: json['cnpj'] as String,
      name: utf8.decode((json['name'] as String).codeUnits),
      email: json['email'] as String,
      phone: json['phone'] as String,
      image: json['image'] as String?,
      description: utf8.decode((json['description'] as String).codeUnits),
      category: categories.firstWhere(
        (category) =>
            category.categoryId ==
            (json['category'] as Map)['categoryId'] as int,
        orElse: () => const ExperienceCategory(
          categoryId: -1,
          name: 'Unknown',
        ),
      ),
      timeDetails: const [],
      socialNetworks: const [],
      tags: (json['tags'] as List? ?? [])
          .map((tag) => Tag.fromJson(tag as Map<String, dynamic>))
          .toSet(),
      images: (json['images'] as List? ?? [])
          .map((image) => image as String)
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
        details,
        category,
        timeDetails,
        socialNetworks,
        tags,
        images,
      ];
}
