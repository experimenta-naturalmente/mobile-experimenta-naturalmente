import 'package:turismo_rural_frontend/core/data/models/attachment.dart';
import 'package:turismo_rural_frontend/core/data/models/experience.dart';
import 'package:turismo_rural_frontend/core/data/models/experience_category.dart';
import 'package:turismo_rural_frontend/core/data/models/opening_hours.dart';
import 'package:turismo_rural_frontend/core/data/models/tag.dart';
import 'package:turismo_rural_frontend/core/utils/common.dart';

class Spot extends Experience {
  final List<OpeningHours> openingHours;

  const Spot({
    required this.openingHours,
    required super.id,
    required super.cnpj,
    required super.name,
    required super.email,
    required super.phone,
    required super.description,
    required super.category,
    required super.socialNetworks,
    required super.tags,
    required super.attachments,
  });

  factory Spot.fromJsonProfile(Map<String, dynamic> json) {
    final openingHoursJson = json['openingHours'] as List? ?? [];

    final openingHours = openingHoursJson
        .map((json) => OpeningHours.fromJson(json as Map<String, dynamic>))
        .toList();

    return Spot(
      openingHours: openingHours,
      id: json['id'] as int,
      cnpj: json['cnpj'] as String,
      name: decodeUtf8(json['name'] as String),
      email: json['email'] as String,
      phone: json['phone'] as String,
      description: decodeUtf8(json['description'] as String),
      category:
          ExperienceCategory.fromJson(json['category'] as Map<String, dynamic>),
      socialNetworks: const [],
      tags: (json['tags'] as List<dynamic>)
          .map((tag) => Tag.fromJson(tag as Map<String, dynamic>))
          .toSet(),
      attachments: (json['attachments'] as List<dynamic>)
          .map(
            (attachment) =>
                Attachment.fromJson(attachment as Map<String, dynamic>),
          )
          .toSet(),
    );
  }

  factory Spot.fromJson(
    Map<String, dynamic> json,
    Set<ExperienceCategory> categories,
  ) {
    final openingHoursJson = json['openingHours'] as List? ?? [];

    final openingHours = openingHoursJson
        .map((json) => OpeningHours.fromJson(json as Map<String, dynamic>))
        .toList();
    return Spot(
      openingHours: openingHours,
      id: json['id'] as int,
      cnpj: json['cnpj'] as String,
      name: decodeUtf8(json['name'] as String),
      email: json['email'] as String,
      phone: json['phone'] as String,
      description: decodeUtf8(json['description'] as String),
      category: categories.firstWhere(
        (category) =>
            category.categoryId ==
            (json['category'] as Map)['categoryId'] as int,
        orElse: () => const ExperienceCategory(
          categoryId: -1,
          name: 'Unknown',
        ),
      ),
      socialNetworks: const [],
      tags: (json['tags'] as List? ?? [])
          .map((tag) => Tag.fromJson(tag as Map<String, dynamic>))
          .toSet(),
      attachments: (json['attachments'] as List? ?? [])
          .map(
            (attachment) =>
                Attachment.fromJson(attachment as Map<String, dynamic>),
          )
          .toSet(),
    );
  }

  factory Spot.fromJsonCategorized(
    Map<String, dynamic> json,
    ExperienceCategory category,
  ) {
    final openingHoursJson = json['openingHours'] as List? ?? [];

    final openingHours = openingHoursJson
        .map((json) => OpeningHours.fromJson(json as Map<String, dynamic>))
        .toList();
    return Spot(
      openingHours: openingHours,
      id: json['id'] as int,
      cnpj: json['cnpj'] as String,
      name: decodeUtf8(json['name'] as String),
      email: json['email'] as String,
      phone: json['phone'] as String,
      description: decodeUtf8(json['description'] as String),
      category: category,
      socialNetworks: const [],
      tags: (json['tags'] as List? ?? [])
          .map((tag) => Tag.fromJson(tag as Map<String, dynamic>))
          .toSet(),
      attachments: (json['attachments'] as List? ?? [])
          .map(
            (attachment) =>
                Attachment.fromJson(attachment as Map<String, dynamic>),
          )
          .toSet(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'openingHours': openingHours,
      'id': id,
      'cnpj': cnpj,
      'name': name,
      'email': email,
      'phone': phone,
      'description': description,
      'category': {'categoryId': category.categoryId},
      'tags': tags.map((tag) => tag.toJson()).toList(),
      'attachments':
          attachments.map((attachment) => attachment.toJson()).toList(),
    };
  }

  @override
  List<Object?> get props => [
        id,
        cnpj,
        name,
        email,
        phone,
        description,
        category,
        openingHours,
        socialNetworks,
        tags,
        attachments,
      ];
}
