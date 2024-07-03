import 'package:turismo_rural_frontend/core/data/models/address.dart';
import 'package:turismo_rural_frontend/core/data/models/attachment.dart';
import 'package:turismo_rural_frontend/core/data/models/experience.dart';
import 'package:turismo_rural_frontend/core/data/models/experience_category.dart';
import 'package:turismo_rural_frontend/core/data/models/tag.dart';
import 'package:turismo_rural_frontend/core/utils/common.dart';

class Event extends Experience {
  final String details;
  final String eventStart;
  final String eventEnd;

  const Event({
    required this.details,
    required this.eventStart,
    required this.eventEnd,
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
    required super.address,
  });

  factory Event.fromJson(
    Map<String, dynamic> json,
    Set<ExperienceCategory> categories,
  ) {
    return Event(
      details: decodeUtf8(json['details'] as String),
      eventStart: json['eventStart'] as String,
      eventEnd: json['eventEnd'] as String,
      id: json['id'] as int,
      cnpj: json['cnpj'] as String,
      name: decodeUtf8(json['name'] as String),
      email: json['email'] as String,
      phone: json['phone'] as String,
      description: decodeUtf8(json['description'] as String),
      address: Address.fromJson(json['address'] as Map<String, dynamic>),
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

  Map<String, dynamic> toJson() {
    return {
      'details': details,
      'eventStart': eventStart,
      'eventEnd': eventEnd,
      'id': id,
      'cnpj': cnpj,
      'name': name,
      'email': email,
      'phone': phone,
      'description': description,
      'category': {'categoryId': category.categoryId},
      'tags': tags.map((tag) => tag.toJson()).toList(),
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
        details,
        category,
        socialNetworks,
        tags,
        attachments,
        eventStart,
        eventEnd,
      ];
}
