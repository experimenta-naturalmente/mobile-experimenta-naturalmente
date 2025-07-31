import 'package:equatable/equatable.dart';
import 'package:turismo_rural_frontend/core/data/models/address.dart';
import 'package:turismo_rural_frontend/core/data/models/attachment.dart';
import 'package:turismo_rural_frontend/core/data/models/event.dart';
import 'package:turismo_rural_frontend/core/data/models/experience_category.dart';
import 'package:turismo_rural_frontend/core/data/models/social_networks.dart';
import 'package:turismo_rural_frontend/core/data/models/spot.dart';
import 'package:turismo_rural_frontend/core/data/models/tag.dart';
import 'package:turismo_rural_frontend/core/utils/enums.dart';

abstract class Experience extends Equatable {
  final String id;
  final ExperienceType type;
  final String? cnpj;
  final String name;
  final String? email;
  final String? phone;
  final String description;
  final Address? address;
  final ExperienceCategory category;
  final SocialNetworks? socialNetworks;
  final Set<Tag> tags;
  final Set<Attachment> attachments;

  const Experience({
    required this.id,
    required this.type,
    required this.cnpj,
    required this.name,
    required this.email,
    required this.phone,
    required this.description,
    required this.category,
    required this.socialNetworks,
    required this.tags,
    required this.attachments,
    required this.address,
  });

  factory Experience.fromJson(
    Map<String, dynamic> json,
    ExperienceCategory category,
    Set<Tag> tags,
  ) {
    final type = ExperienceType.values.firstWhere(
      (e) => e.name == json['type'],
      orElse: () => ExperienceType.spot,
    );

    switch (type) {
      case ExperienceType.spot:
        return Spot.fromJson(json, category, tags);
      case ExperienceType.event:
        return Event.fromJson(json, category, tags);
      default:
        throw Exception('Unsupported ExperienceType: $type');
    }
  }
}
