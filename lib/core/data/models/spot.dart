import 'package:turismo_rural_frontend/core/data/models/address.dart';
import 'package:turismo_rural_frontend/core/data/models/attachment.dart';
import 'package:turismo_rural_frontend/core/data/models/experience.dart';
import 'package:turismo_rural_frontend/core/data/models/experience_category.dart';
import 'package:turismo_rural_frontend/core/data/models/opening_hours.dart';
import 'package:turismo_rural_frontend/core/data/models/social_networks.dart';
import 'package:turismo_rural_frontend/core/data/models/tag.dart';
import 'package:turismo_rural_frontend/core/utils/common.dart';
import 'package:turismo_rural_frontend/core/utils/enums.dart';

class Spot extends Experience {
  final List<OpeningHours> openingHours;

  const Spot({
    required this.openingHours,
    required super.id,
    required super.type,
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

  factory Spot.fromJsonProfile(Map<String, dynamic> json) {
    final openingHoursJson = json['openingHours'];
    List<OpeningHours> openingHours = [];

    if (openingHoursJson is List) {
      openingHours = openingHoursJson
          .map((json) => OpeningHours.fromJson(json as Map<String, dynamic>))
          .toList();
    }

    return Spot(
      openingHours: openingHours,
      id: json['id'] != null
          ? (json['id'] is int ? json['id'].toString() : json['id'] as String)
          : '',
      type: ExperienceType.spot,
      cnpj: json['cnpj'] != null ? json['cnpj'] as String : '',
      name:
          json['name'] != null ? decodeUtf8(json['name'] as String) : 'Unknown',
      email: json['email'] != null ? json['email'] as String : '',
      phone: json['phone'] != null ? json['phone'] as String : '',
      description: json['description'] != null
          ? decodeUtf8(json['description'] as String)
          : '',
      address: json['address'] != null
          ? Address.fromJson(json['address'] as Map<String, dynamic>)
          : Address(street: 'Unknown', number: 0, zipCode: ''),
      category: const ExperienceCategory(id: 'unknown', name: 'Unknown'),
      socialNetworks: json['socialNetworks'] != null
          ? SocialNetworks.fromJson(
              json['socialNetworks'] as Map<String, dynamic>)
          : null,
      tags: (json['tags'] as List? ?? []).map((tag) {
        if (tag is String) {
          return Tag(id: '0', name: tag, type: []);
        }
        return Tag.fromJson(tag as Map<String, dynamic>);
      }).toSet(),
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
    final openingHoursJson = json['openingHours'];
    List<OpeningHours> openingHours = [];

    if (openingHoursJson is List) {
      openingHours = openingHoursJson
          .map((json) => OpeningHours.fromJson(json as Map<String, dynamic>))
          .toList();
    }

    return Spot(
      openingHours: openingHours,
      id: json['id'] != null
          ? (json['id'] is int ? json['id'].toString() : json['id'] as String)
          : '',
      type: ExperienceType.spot,
      cnpj: json['cnpj'] != null ? json['cnpj'] as String : '',
      name:
          json['name'] != null ? decodeUtf8(json['name'] as String) : 'Unknown',
      email: json['email'] != null ? json['email'] as String : '',
      phone: json['phone'] != null ? json['phone'] as String : '',
      description: json['description'] != null
          ? decodeUtf8(json['description'] as String)
          : '',
      address: json['address'] != null
          ? Address.fromJson(json['address'] as Map<String, dynamic>)
          : Address(street: 'Unknown', number: 0, zipCode: ''),
      category: () {
        final categoryMap = json['category'] as Map?;
        final categoryId = categoryMap?['id']?.toString();
        return categories.firstWhere(
          (category) => categoryId != null && category.id == categoryId,
          orElse: () =>
              const ExperienceCategory(id: 'unknown', name: 'Unknown'),
        );
      }(),
      socialNetworks: json['socialNetworks'] != null
          ? SocialNetworks.fromJson(
              json['socialNetworks'] as Map<String, dynamic>,
            )
          : null,
      tags: (json['tags'] as List? ?? []).map((tag) {
        if (tag is String) {
          return Tag(id: '0', name: tag, type: []);
        }
        return Tag.fromJson(tag as Map<String, dynamic>);
      }).toSet(),
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
    final openingHoursJson = json['openingHours'];
    List<OpeningHours> openingHours = [];

    if (openingHoursJson is List) {
      openingHours = openingHoursJson
          .map((json) => OpeningHours.fromJson(json as Map<String, dynamic>))
          .toList();
    }

    return Spot(
      openingHours: openingHours,
      id: json['id'] != null
          ? (json['id'] is int ? json['id'].toString() : json['id'] as String)
          : '',
      type: ExperienceType.spot,
      cnpj: json['cnpj'] != null ? json['cnpj'] as String : '',
      name:
          json['name'] != null ? decodeUtf8(json['name'] as String) : 'Unknown',
      email: json['email'] != null ? json['email'] as String : '',
      phone: json['phone'] != null ? json['phone'] as String : '',
      description: json['description'] != null
          ? decodeUtf8(json['description'] as String)
          : '',
      address: json['address'] != null
          ? Address.fromJson(json['address'] as Map<String, dynamic>)
          : Address(street: 'Unknown', number: 0, zipCode: ''),
      category: category,
      socialNetworks: json['socialNetworks'] != null
          ? SocialNetworks.fromJson(
              json['socialNetworks'] as Map<String, dynamic>,
            )
          : null,
      tags: (json['tags'] as List? ?? []).map((tag) {
        if (tag is String) {
          return Tag(id: '0', name: tag, type: []);
        }
        return Tag.fromJson(tag as Map<String, dynamic>);
      }).toSet(),
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
      'category': {'id': category.id},
      'tags': tags.map((tag) => tag.toJson()).toList(),
      'attachments':
          attachments.map((attachment) => attachment.toJson()).toList(),
    };
  }

  @override
  List<Object?> get props => [
        id,
        type,
        cnpj,
        name,
        email,
        phone,
        description,
        address,
        category,
        socialNetworks,
        tags,
        attachments,
        openingHours,
      ];
}
